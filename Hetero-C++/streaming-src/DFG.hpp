#pragma once

#include <hpvm_hdc.hpp>
#include <heterocc.h>

#undef D
#undef N_FEATURES
#undef K

// RANDOM PROJECTION ENCODING!!
// Matrix-vector mul
// RP encoding reduces N_features -> D 
template<int D, int N_FEATURES>
void rp_encoding_node(/* Input Buffers: 2*/
        binary* rp_matrix_ptr, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
        int* input_datapoint_ptr, size_t input_datapoint_size, // __hypervector__<N_FEATURES, int> 
        /* Output Buffers: 1*/
        binary* output_hv_ptr, size_t output_hv_size) { // __hypervector__<D, binary>
    
    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(
        /* Input Buffers: 2*/ 3, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size,
        /* Parameters: 0*/
        /* Output Buffers: 1*/ 1, output_hv_ptr, output_hv_size
    );

    // To convert to streaming implementation, just remove the parallel loop and only provide one HV at a time.
    typename __hypervector__<D, int> encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, int>(*(typename __hypervector__<N_FEATURES, int>*)(input_datapoint_ptr), *((__hypermatrix__<D, N_FEATURES, int>*)(rp_matrix_ptr))); 
    typename __hypervector__<D, binary> bipolar_encoded_hv = __hetero_hdc_sign<D, int>(encoded_hv);
    *((typename __hypervector__<D, binary>*)output_hv_ptr) = bipolar_encoded_hv;

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
template<int D, int K, int N_VEC>
void clustering_node(/* Input Buffers: 3*/
        int* encoded_hv_ptr, size_t encoded_hv_size, // __hypervector__<D, binary>
        int* clusters_ptr, size_t clusters_size, // __hypermatrix__<K, D, binary>
        int* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
        /* Output Buffers: 1*/
        int* labels, size_t labels_size) { // Mapping of HVs to Clusters. int[N_VEC]

    void* section = __hetero_section_begin();

    void* cluster_task = __hetero_task_begin(
        /* Input Buffers: 4*/ 4, encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, temp_clusters_ptr, temp_clusters_size, labels, labels_size, 
        /* Output Buffers: 1*/ 1, labels, labels_size
    );


    typename __hypervector__<D, int> encoded_hv = *((typename __hypervector__<D, int>*)encoded_hv_ptr);
    __hypermatrix__<K, D, int> clusters = *((__hypermatrix__<K, D, int>*)clusters_ptr);

    // Do we need to store the distances??
    //int distances[K]; // Store dot-products to eventually calculate similarity.

    int max_score = 0;
    int max_idx = 0;
    // Could instead use a vector-matrix (encoded_hv X clusters)intrinsic to avoid looping over all clusters.
    for (int k = 0 ; k < K; k++) {
        typename __hypervector__<D, int> cluster_center = __hetero_hdc_get_matrix_row<K, D, int>(clusters, k);
        // FPGA implementation does optimizations where it stores the magnitude of the center hvs, so it doesn't have to re-calculate them each time we do cossim
        // If we really wanted spped, we should just use hamming distance. 
        //distances[k] 
        //int score = D - __hetero_hdc_hamming_distance<D, int>(encoded_hv, cluster_center); 
        int score = __hetero_hdc_cossim<D, int>(encoded_hv, cluster_center); 
        // TOOD: There is some weird stuff going on with the sign in the FPGA implementation, look into that.
        if (score > max_score) {
            max_score = score;
            max_idx = k;
        }
    }

    // Update temp cluster center
    // Tragic that we have to extract the row, 

    // Accumulate to temp_clusters_ptr. // 
    auto temp = __hetero_hdc_get_matrix_row<K, D, int>(*(__hypermatrix__<K, D, int>*)(temp_clusters_ptr), max_idx);
    __hetero_hdc_set_matrix_row<K, D, int>(*(__hypermatrix__<K, D, int>*)(temp_clusters_ptr), temp += encoded_hv, max_idx);

    __hetero_task_end(cluster_task);
    __hetero_section_end(section);
    return;
}

// Dimensionality, Clusters, data point vectors, features per.
template <int D, int K, int N_VEC, int N_FEATURES>
void root_node( /* Input buffers: 2*/ 
                int* rp_matrix_ptr, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
                int* datapoint_vec_ptr, size_t datapoint_vec_size, // Features
                /* Local Vars: 1*/
                int* encoded_hv_ptr, size_t encoded_hv_size, // // __hypervector__<D, binary>
                int* clusters_ptr, size_t clusters_size, // __hypermatrix__<K, D, binary>
                int* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
                /* Parameters: 1*/
                int num_iterations, int convergence_threshold,
                /* Output Buffers: 1*/
                int* labels, size_t labels_size){

    void* root_section = __hetero_section_begin();

    void* root_task = __hetero_task_begin(
        /* Input Buffers: 6 */ 6, rp_matrix_ptr, rp_matrix_size, datapoint_vec_ptr, datapoint_vec_size, 
                                encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, 
                                temp_clusters_ptr, temp_clusters_size, labels, labels_size,
        /* Output Buffers: 1 */ 1, labels, labels_size,
        "Root_Task"  
    );

    // Split these into two tasks??
    rp_encoding_node<D, N_FEATURES>(rp_matrix_ptr, rp_matrix_size, datapoint_vec_ptr, datapoint_vec_size, encoded_hv_ptr, encoded_hv_size);

    clustering_node<D, K, N_VEC>(encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, temp_clusters_ptr, temp_clusters_size, labels, labels_size); 

    __hetero_task_end(root_task);

    __hetero_section_end(root_section);
    return;
}