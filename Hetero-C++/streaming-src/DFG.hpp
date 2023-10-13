#pragma once

#include <hpvm_hdc.h>
#include <heterocc.h>
#include <iostream>

#define HAMMING_DIST

#undef D
#undef N_FEATURES
#undef K

typedef int binary;
typedef int hvtype;

// RANDOM PROJECTION ENCODING!!
// Matrix-vector mul
// Encodes a single vector using a random projection matrix
//
// RP encoding reduces N_features -> D 
template<int D, int N_FEATURES>
void  rp_encoding_node(/* Input Buffers: 2*/
        __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
        __hypervector__<N_FEATURES, hvtype>* input_datapoint_ptr, size_t input_datapoint_size, // __hypervector__<N_FEATURES, int> 
        /* Output Buffers: 1*/
        __hypervector__<D, hvtype>* output_hv_ptr, size_t output_hv_size) { // __hypervector__<D, binary>
    
    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(
        /* Input Buffers: 2*/ 3, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size,
        /* Parameters: 0*/
        /* Output Buffers: 1*/ 1, output_hv_ptr, output_hv_size,
        "inner_rp_encoding_task"
    );

    //std::cout << "encoding node" << std::endl;
    
    /**
    __hypervector__<D, hvtype> encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, hvtype>(*input_datapoint_ptr, *rp_matrix_ptr); 
    // Uses the output_hv_ptr for the buffer. So that we can lower to 
    // additional tasks. We should do an optimization in the bufferization
    // analysis to re-use the same buffer (especially those coming from the
    // formal parameters) to enable more of these tasks to become parallel loops.

    
    //

    // Not quantized:
    #ifdef HAMMING_DIST
    __hypervector__<D, hvtype> bipolar_encoded_hv = __hetero_hdc_sign<D, hvtype>(encoded_hv);
    *output_hv_ptr = bipolar_encoded_hv;
    #else
    *output_hv_ptr = encoded_hv;
    #endif */

    //std::cout << "encoding node end" << std::endl;

    __hetero_task_end(task); 

    __hetero_section_end(section);
    return;
}


// RP encoding reduces N_features -> D 
template<int D, int N_FEATURES>
void  rp_encoding_node_copy(/* Input Buffers: 2*/
        __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
        __hypervector__<N_FEATURES, hvtype>* input_datapoint_ptr, size_t input_datapoint_size, // __hypervector__<N_FEATURES, int> 
        /* Output Buffers: 1*/
        __hypervector__<D, hvtype>* output_hv_ptr, size_t output_hv_size) { // __hypervector__<D, binary>
    
    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(
        /* Input Buffers: 2*/ 3, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size,
        /* Parameters: 0*/
        /* Output Buffers: 1*/ 1, output_hv_ptr, output_hv_size,
        "inner_rp_encoding_copy_task"
    );

    //std::cout << "encoding node copy" << std::endl;
    
    /**
    __hypervector__<D, hvtype> encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, hvtype>(*input_datapoint_ptr, *rp_matrix_ptr); 
    // Uses the output_hv_ptr for the buffer. So that we can lower to 
    // additional tasks. We should do an optimization in the bufferization
    // analysis to re-use the same buffer (especially those coming from the
    // formal parameters) to enable more of these tasks to become parallel loops.
    #ifdef HAMMING_DIST
    __hypervector__<D, hvtype> bipolar_encoded_hv = __hetero_hdc_sign<D, hvtype>(encoded_hv);
    *output_hv_ptr = bipolar_encoded_hv;
    #else
    *output_hv_ptr = encoded_hv;
    #endif
    */

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
        __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, // __hypervector__<D, binary>
        __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, // __hypermatrix__<K, D, binary>
        __hypermatrix__<K, D, hvtype>* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
        __hypervector__<K, hvtype>* scores_ptr, size_t scores_size, // Used as Local var.
        int encoded_hv_idx,
        /* Output Buffers: 1*/
        int* labels, size_t labels_size) { // Mapping of HVs to Clusters. int[N_VEC]

    void* section = __hetero_section_begin();

    void* task1 = __hetero_task_begin(
        /* Input Buffers: 4*/ 3, encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, scores_ptr, scores_size, 
        /* Output Buffers: 1*/ 1,  scores_ptr, scores_size, "clustering_scoring_task"
    );

     // Scoping hack in order to have 'scores' defined in each task.

    
    

    //std::cout << "clustering task 1" << std::endl;

    /**

    __hypervector__<D, hvtype> encoded_hv = *encoded_hv_ptr;
    __hypermatrix__<K, D, hvtype> clusters = *clusters_ptr;

    // unclear if this should be a 'hypervector' (beacuse it is only of dimension K, very small.)
    __hypervector__<K, hvtype> scores = *scores_ptr; // Precision of these scores might need to be increased
    std::cout << "before hamming" << std::endl; */

    /**
    std::cout << "task 1 scores before:\n";
    for (int i = 0; i < 5; i++) {
        std::cout << (*scores_ptr)[0][i] << " ";
        std::cout << ((hvtype*)scores_ptr)[i] << " ";
    }

    std::cout << "\n";

    std::cout << "task 1 clusters before:\n";
    for (int i = 0; i < 5; i++) {
        std::cout << (*clusters_ptr)[0][i] << " ";
        
    }

    
    std::cout << "\n";

    std::cout << "task 1 encdoded_hv before:\n";
    for (int i = 0; i < 5; i++) {
        std::cout << (*encoded_hv_ptr)[0][i] << " ";

    } 

    std::cout << "\n"; */


    #ifdef HAMMING_DIST
    *scores_ptr =  __hetero_hdc_hamming_distance<K, D, hvtype>(*encoded_hv_ptr, *clusters_ptr);
    #else
    *scores_ptr = __hetero_hdc_cossim<K, D, hvtype>(encoded_hv, clusters);
    #endif

    //std::cout << "after hamming" << std::endl;
    /*
    std::cout << "task 1 scores:\n";
    for (int i = 0; i < 5; i++) {
        std::cout << (*scores_ptr)[0][i] << " ";
        std::cout << ((hvtype*)scores_ptr)[i] << " ";
    }

    std::cout << "\n"; */

    std::cout << "cluster task 1" << std::endl; // WHY DOES THIS BREAK THINGS???????!

    //__hypervector__<D, int> cluster_center = __hetero_hdc_hypervector<D, int>();

    __hetero_task_end(task1);
    void* task2 = __hetero_task_begin(
        /* Input Buffers: 1*/ 4 + 1, scores_ptr, scores_size, labels, labels_size, encoded_hv_ptr, encoded_hv_size, temp_clusters_ptr, temp_clusters_size,
        /* paramters: 1*/      encoded_hv_idx,
        /* Output Buffers: 1*/ 2,  temp_clusters_ptr, temp_clusters_size, labels, labels_size, "find_score_and_update_task"
    );
    #if 0
    
    {
   

    
    //std::cout << "clustering task 2" << std::endl;
    __hypervector__<K, hvtype> scores = *scores_ptr;
    int max_idx = 0;

    std::cout << "task 2 scores:\n";
    for (int i = 0; i < 5; i++) {
        std::cout << (*scores_ptr)[0][i] << " ";
    }

    std::cout << "\n";

    // IF using hamming distance:

    #ifdef HAMMING_DIST
    hvtype max_score = (hvtype) (D - (*scores_ptr)[0][0]); // I think this is probably causing issues.
    #else
    hvtype max_score = (hvtype) (*scores_ptr)[0][0];
    #endif
    
    for (int k = 0; k < K; k++) {
        #ifdef HAMMING_DIST
        hvtype score = (hvtype) (D - (*scores_ptr)[0][k]);
        #else
        hvtype score = (hvtype) (*scores_ptr)[0][k];
        #endif
        //std::cout << score << " ";
        if (score > max_score) {
            
            max_score = score;
            max_idx = k;
        }
    } 
    // Write labels
    //std::cout << encoded_hv_idx << "|" << max_idx << " ";
    //max_idx = (encoded_hv_idx >> 1) % K;
    labels[encoded_hv_idx] = max_idx;

    //std::cout << "after write to labels" << std::endl;

    // Accumulate to temp clusters
    //auto temp = __hetero_hdc_hypervector<D, int>();

    // Unclear if this actually works as intended.
    auto temp = __hetero_hdc_get_matrix_row<K, D, hvtype>(*temp_clusters_ptr, K, D, max_idx);
    temp = __hetero_hdc_sum<D, hvtype>(temp, *encoded_hv_ptr); // May need an instrinsic for this.
    __hetero_hdc_set_matrix_row<K, D, hvtype>(*temp_clusters_ptr, temp, max_idx); // How do we normalize?
    
    //std::cout << "clustering task 2 end" << std::endl;

    
    }
    #endif
    __hetero_task_end(task2);
    __hetero_section_end(section);
    return;
}

// Dimensionality, Clusters, data point vectors, features per.
template <int D, int K, int N_VEC, int N_FEATURES>
void root_node( /* Input buffers: 4*/ 
                __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
                __hypervector__<N_FEATURES, hvtype>* datapoint_vec_ptr, size_t datapoint_vec_size, // Features
                __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, // __hypermatrix__<K, D, binary>
                __hypermatrix__<K, D, hvtype>* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
                /* Local Vars: 2*/
                __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, // // __hypervector__<D, binary>
                
                __hypervector__<K, hvtype>* scores_ptr, size_t scores_size,
                /* Parameters: 2*/
                int labels_index, int convergence_threshold, // <- not used.
                /* Output Buffers: 2*/
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
                                encoded_hv_ptr, encoded_hv_size, 
                                clusters_ptr, clusters_size, 
                                temp_clusters_ptr, temp_clusters_size, 
                                labels, labels_size,
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
