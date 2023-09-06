#pragma once

#include <hpvm_hdc.h>
#include <heterocc.h>

#undef D
#undef N_FEATURES
#undef K

typedef int binary;

// RANDOM PROJECTION ENCODING!!
// Matrix-vector mul
// Encodes a single vector using a random projection matrix
//
// RP encoding reduces N_features -> D 
template<int D, int N_FEATURES>
void rp_encoding_node(/* Input Buffers: 2*/
        __hypermatrix__<D, N_FEATURES, int>* rp_matrix_ptr, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
        __hypervector__<N_FEATURES, int>* input_datapoint_ptr, size_t input_datapoint_size, // __hypervector__<N_FEATURES, int> 
        /* Output Buffers: 1*/
        __hypervector__<D, int>* output_hv_ptr, size_t output_hv_size) { // __hypervector__<D, binary>
    
    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(
        /* Input Buffers: 2*/ 3, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size,
        /* Parameters: 0*/
        /* Output Buffers: 1*/ 1, output_hv_ptr, output_hv_size,
        "inner_rp_encoding_task"
    );
    
    __hypervector__<D, int> encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, int>(*input_datapoint_ptr, *rp_matrix_ptr); 
    __hypervector__<D, int> bipolar_encoded_hv = __hetero_hdc_sign<D, int>(encoded_hv);
    *output_hv_ptr = bipolar_encoded_hv;

    __hetero_task_end(task); 

    __hetero_section_end(section);
    return;
}

// clustering_node is the hetero-c++ version of searchUnit from the original FPGA code.
// It pushes some functionality to the loop that handles the iterations.
// For example, updating the cluster centers is not done here.
// Initializing the centroids is not done here.
// Node gets run max_iterations times.
// Dimensionality, number of clusters, number of vectors

// In the streaming implementation, this runs for each encoded HV, so N_VEC * EPOCHs times.
template<int D, int K, int N_VEC>
void clustering_node(/* Input Buffers: 3*/
        __hypervector__<D, int>* encoded_hv_ptr, size_t encoded_hv_size, // __hypervector__<D, binary>
        __hypermatrix__<K, D, int>* clusters_ptr, size_t clusters_size, // __hypermatrix__<K, D, binary>
        __hypermatrix__<K, D, int>* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
        __hypervector__<K, int>* scores_ptr, size_t scores_size, // Used as Local var.
        int encoded_hv_idx,
        /* Output Buffers: 1*/
        int* labels, size_t labels_size) { // Mapping of HVs to Clusters. int[N_VEC]

    void* section = __hetero_section_begin();

    { // Scoping hack in order to have 'scores' defined in each task.

    void* task1 = __hetero_task_begin(
        /* Input Buffers: 4*/ 3, encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, scores_ptr, scores_size, 
        /* Output Buffers: 1*/ 1,  scores_ptr, scores_size, "clustering_scoring_task"
    );

    __hypervector__<D, int> encoded_hv = *encoded_hv_ptr;
    __hypermatrix__<K, D, int> clusters = *clusters_ptr;
    __hypervector__<K, int> scores = *scores_ptr;

    *scores_ptr = __hetero_hdc_hamming_distance<K, D, int>(encoded_hv, clusters);

    // Do we need to store the scores??
    //int scores[K]; // Store dot-products to eventually calculate similarity.

    //__hypervector__<D, int> cluster_center = __hetero_hdc_hypervector<D, int>();

    // Previous:

    /*
    for (int k = 0 ; k < K; k++) {
        cluster_center = __hetero_hdc_get_matrix_row<K, D, int>(clusters, K, D, k);
        // FPGA implementation does optimizations where it stores the magnitude of the center hvs, so it doesn't have to re-calculate them each time we do cossim
        // If we really wanted spped, we should just use hamming distance. 
        //scores[k] 
        int score = D - __hetero_hdc_hamming_distance<D, int>(encoded_hv, cluster_center); 
        //int score = __hetero_hdc_cossim<D, int>(encoded_hv, cluster_center); 
        
        if (score > max_score) {
            max_score = score;
            max_idx = k;
        }
    } */


   __hetero_task_end(task1);
    }
    {
   void* task2 = __hetero_task_begin(
        /* Input Buffers: 1*/ 4 + 1, scores_ptr, scores_size, labels, labels_size, encoded_hv_ptr, encoded_hv_size, temp_clusters_ptr, temp_clusters_size,
        /* paramters: 1*/      encoded_hv_idx,
        /* Output Buffers: 1*/ 1,  labels, labels_size, "find_score_and_update_task"
    );

    __hypervector__<K, int> scores = *scores_ptr;

    // IF using hamming distance:
    int max_score = scores[0][0];
    int max_idx = 0;

    for (int k = 0; k < K; k++) {
        int dist = scores[0][k];
        if (dist < max_score) {
            max_score = max_score;
            max_idx = k;
        }
    }
    // Write labels
    labels[encoded_hv_idx] = max_idx;

    // TODO: Should this be a separate task??

    // Accumulate to temp clusters
    auto temp = __hetero_hdc_hypervector<D, int>();
    temp = __hetero_hdc_get_matrix_row<K, D, int>(*temp_clusters_ptr, K, D, max_idx);
    //temp = temp + *encoded_hv_ptr; // May need an instrinsic for this.
    __hetero_hdc_set_matrix_row<K, D, int>(*temp_clusters_ptr, temp, max_idx); // How do we normalize?

    __hetero_task_end(task2);
    }
    __hetero_section_end(section);
    return;
}

// Dimensionality, Clusters, data point vectors, features per.
template <int D, int K, int N_VEC, int N_FEATURES>
void root_node( /* Input buffers: 2*/ 
                __hypermatrix__<D, N_FEATURES, int>* rp_matrix_ptr, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
                __hypervector__<N_FEATURES, int>* datapoint_vec_ptr, size_t datapoint_vec_size, // Features
                /* Local Vars: 4*/
                __hypervector__<D, int>* encoded_hv_ptr, size_t encoded_hv_size, // // __hypervector__<D, binary>
                __hypermatrix__<K, D, int>* clusters_ptr, size_t clusters_size, // __hypermatrix__<K, D, binary>
                __hypermatrix__<K, D, int>* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
                __hypervector__<K, int>* scores_ptr, size_t scores_size,
                /* Parameters: 2*/
                int labels_index, int convergence_threshold, // <- not used.
                /* Output Buffers: 1*/
                int* labels, size_t labels_size){

    void* root_section = __hetero_section_begin();

    // Re-encode each iteration.
    void* encoding_task = __hetero_task_begin(
        /* Input Buffers: 3 */ 3, rp_matrix_ptr, rp_matrix_size, datapoint_vec_ptr, datapoint_vec_size, 
                                encoded_hv_ptr, encoded_hv_size,
        /* Output Buffers: 1 */ 1, encoded_hv_ptr, encoded_hv_size,
        "encoding_task"  
    );

    rp_encoding_node<D, N_FEATURES>(rp_matrix_ptr, rp_matrix_size, datapoint_vec_ptr, datapoint_vec_size, encoded_hv_ptr, encoded_hv_size);

    __hetero_task_end(encoding_task);

    void* clustering_task = __hetero_task_begin(
        /* Input Buffers: 5 */  5 + 1, 
                                encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, 
                                temp_clusters_ptr, temp_clusters_size, labels, labels_size,
                                scores_ptr, scores_size,
        /* Parameters: 1 */     labels_index,
        /* Output Buffers: 1 */ 2, labels, labels_size, temp_clusters_ptr, temp_clusters_size,
        "clustering_task"  
    );

    clustering_node<D, K, N_VEC>(encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, temp_clusters_ptr, temp_clusters_size, scores_ptr, scores_size, labels_index, labels, labels_size); 

    __hetero_task_end(clustering_task);

    __hetero_section_end(root_section);
    return;
}