#pragma once

#include <hpvm_hdc.h>
#include <heterocc.h>
#include <iostream>

//#define HAMMING_DIST

#undef D
#undef N_FEATURES
#undef K

typedef int binary;
typedef float hvtype;


#ifdef HAMMING_DIST
#define SCORES_TYPE hvtype
#else
#define SCORES_TYPE float
#endif

#ifndef DEVICE
#define DEVICE 1
#endif

// RANDOM PROJECTION ENCODING!!
// Matrix-vector mul
// Encodes a single vector using a random projection matrix
//
// RP encoding reduces N_features -> D 

template <typename T>
T zero_hv(size_t loop_index_var) {
	return 0;
}


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

    
    
    __hypervector__<D, hvtype> encoded_hv = __hetero_hdc_create_hypervector<D, hvtype>(0, (void*) zero_hv<hvtype>);
    *output_hv_ptr = encoded_hv;

    encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, hvtype>(*input_datapoint_ptr, *rp_matrix_ptr); 
    // Uses the output_hv_ptr for the buffer. So that we can lower to 
    // additional tasks. We should do an optimization in the bufferization
    // analysis to re-use the same buffer (especially those coming from the
    // formal parameters) to enable more of these tasks to become parallel loops.
    *output_hv_ptr = encoded_hv;
    
    #ifdef HAMMING_DIST
    __hypervector__<D, int> bipolar_encoded_hv = __hetero_hdc_sign<D, int>(encoded_hv);
    *output_hv_ptr = bipolar_encoded_hv;
    #endif


    __hetero_task_end(task); 

    __hetero_section_end(section);
    return;
}



// RP encoding reduces N_features -> D 
template<int D, int N_FEATURES>
void  rp_encoding_node_copy(/* Input Buffers: 2*/
        __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, 
        __hypervector__<N_FEATURES, hvtype>* input_datapoint_ptr, size_t input_datapoint_size, 
        /* Output Buffers: 1*/
        __hypervector__<D, hvtype>* output_hv_ptr, size_t output_hv_size) {
    
    void* section = __hetero_section_begin();



    void* task = __hetero_task_begin(
        /* Input Buffers: 2*/ 3, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size,
        /* Parameters: 0*/
        /* Output Buffers: 1*/ 1, output_hv_ptr, output_hv_size,
        "inner_rp_encoding_copy_task"
    );


    __hypervector__<D, hvtype> encoded_hv = __hetero_hdc_create_hypervector<D, hvtype>(0, (void*) zero_hv<hvtype>);
    *output_hv_ptr = encoded_hv;
    
    encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, hvtype>(*input_datapoint_ptr, *rp_matrix_ptr); 
    *output_hv_ptr = encoded_hv;
    // Uses the output_hv_ptr for the buffer. So that we can lower to 
    // additional tasks. We should do an optimization in the bufferization
    // analysis to re-use the same buffer (especially those coming from the
    // formal parameters) to enable more of these tasks to become parallel loops.
    

    #ifdef HAMMING_DIST
    __hypervector__<D, int> bipolar_encoded_hv = __hetero_hdc_sign<D, int>(encoded_hv);
    *output_hv_ptr = bipolar_encoded_hv;
    #endif


    __hetero_task_end(task); 

    __hetero_section_end(section);
    return;
}


// RP encoding reduces N_features -> D 
template<int D, int N_FEATURES>
void  InitialEncodingDAG(/* Input Buffers: 2*/
        __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, 
        __hypervector__<N_FEATURES, hvtype>* input_datapoint_ptr, size_t input_datapoint_size, 
        /* Output Buffers: 1*/
        __hypervector__<D, hvtype>* output_hv_ptr, size_t output_hv_size) {

    
    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(
        /* Input Buffers: 2*/ 3, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size,
        /* Parameters: 0*/
        /* Output Buffers: 1*/ 1, output_hv_ptr, output_hv_size,
        "initial_encoding_wrapper"
    );

    // Specifies that the following node is performing an HDC Encoding step
    __hetero_hdc_encoding(6, (void*)  rp_encoding_node_copy<D, N_FEATURES>, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size);

    __hetero_task_end(task); 
    __hetero_section_end(section);
}

// clustering_node is the hetero-c++ version of searchUnit from the original FPGA code.
// It pushes some functionality to the loop that handles the iterations.
// For example, updating the cluster centers is not done here.
// Initializing the centroids is not done here.
// Node gets run max_iterations times.
// Dimensionality, number of clusters, number of vectors


// In the streaming implementation, this runs for each encoded HV, so N_VEC * EPOCHs times.
template<int D, int K, int N_VEC>
void __attribute__ ((noinline)) clustering_node(/* Input Buffers: 3*/
        __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, 
        __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, 
        __hypermatrix__<K, D, hvtype>* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
        __hypervector__<K, SCORES_TYPE>* scores_ptr, size_t scores_size, // Used as Local var.
        __hypervector__<D, hvtype>* update_hv_ptr, size_t update_hv_size,  // Used in second stage of clustering node for extracting and accumulating
        int encoded_hv_idx,
        /* Output Buffers: 1*/
        int* labels, size_t labels_size) { // Mapping of HVs to Clusters. int[N_VEC]

    void* section = __hetero_section_begin();


    { // Scoping hack in order to have 'scores' defined in each task.


    
    void* task1 = __hetero_task_begin(
        /* Input Buffers: 4*/ 3, encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, scores_ptr, scores_size, 
        /* Output Buffers: 1*/ 1,  scores_ptr, scores_size, "clustering_scoring_task"
    );


    __hypervector__<D, hvtype> encoded_hv = *encoded_hv_ptr;
    __hypermatrix__<K, D, hvtype> clusters = *clusters_ptr;

    __hypervector__<K, SCORES_TYPE> scores = *scores_ptr; // Precision of these scores might need to be increased.

    #ifdef HAMMING_DIST
    *scores_ptr =  __hetero_hdc_hamming_distance<K, D, hvtype>(encoded_hv, clusters);
    #else
    *scores_ptr = __hetero_hdc_cossim<K, D, hvtype>(encoded_hv, clusters);
    #endif

   __hetero_task_end(task1);
    }
    
    {
   void* task2 = __hetero_task_begin(
        /* Input Buffers: 1*/ 4, encoded_hv_ptr, encoded_hv_size, scores_ptr, scores_size, labels, labels_size,
        /* paramters: 1*/      encoded_hv_idx,
        /* Output Buffers: 1*/ 2, encoded_hv_ptr, encoded_hv_size, labels, labels_size, "find_score_and_label_task"
    );

    
    __hypervector__<K, hvtype> scores = *scores_ptr;
    int max_idx = 0;

    // IF using hamming distance:
    
    #ifdef HAMMING_DIST
    SCORES_TYPE max_score = (SCORES_TYPE) D - (*scores_ptr)[0][0]; // I think this is probably causing issues.
    #else
    SCORES_TYPE max_score = (SCORES_TYPE) (*scores_ptr)[0][0];
    #endif
    
    for (int k = 0; k < K; k++) {
        #ifdef HAMMING_DIST
        SCORES_TYPE score = (SCORES_TYPE) D - (*scores_ptr)[0][k];
        #else
        SCORES_TYPE score = (SCORES_TYPE) (*scores_ptr)[0][k];
        #endif
        if (score > max_score) {
            max_score = score;
            max_idx = k;
        }
        
    } 
    // Write labels
    //labels[encoded_hv_idx] = max_idx;
    *labels = max_idx;



    __hetero_task_end(task2);
    }
    __hetero_section_end(section);
    return;
}




// RP Matrix Node Generation. Performs element wise rotation on ID matrix rows and stores into destination buffer.
template <int D,  int N_FEATURES>
void gen_rp_matrix(/* Input Buffers*/
        __hypervector__<D, hvtype>* rp_seed_vector, size_t  rp_seed_vector_size,
        __hypervector__<D, hvtype>* row_buffer, size_t  row_buffer_size,
        __hypermatrix__<N_FEATURES, D, hvtype>* shifted_matrix, size_t  shifted_matrix_size,
        __hypermatrix__<D, N_FEATURES, hvtype>* transposed_matrix, size_t  transposed_matrix_size
        ){


    void* root_section = __hetero_section_begin();


    void* root_task = __hetero_task_begin(
            /* Num Inputs */ 4,
         rp_seed_vector,   rp_seed_vector_size,
         shifted_matrix,   shifted_matrix_size,
         row_buffer, row_buffer_size,
         transposed_matrix,   transposed_matrix_size,
         /* Num Outputs*/ 1,
         transposed_matrix,   transposed_matrix_size,
        "gen_root_task"
    );

    void* wrapper_section = __hetero_section_begin();


    {
    void* gen_shifted_task = __hetero_task_begin(
         /* Num Inputs */ 3,
         rp_seed_vector,   rp_seed_vector_size,
         shifted_matrix,   shifted_matrix_size,
         row_buffer, row_buffer_size,
         /* Num Outputs */ 1,
         shifted_matrix,   shifted_matrix_size,
         "gen_shifted_matrix_task");


    //std::cout << "Gen Shifted Task Begin" <<std::endl;
	// Each row is just a wrap shift of the seed.

	for (int i = 0; i < N_FEATURES; i++) {
		__hypervector__<D, hvtype>  row = __hetero_hdc_wrap_shift<D, hvtype>(*rp_seed_vector, i);
        *row_buffer = row;
        __hetero_hdc_set_matrix_row<N_FEATURES, D, hvtype>(*shifted_matrix, row, i);

	} 

    //std::cout << "Gen Shifted Task End" <<std::endl;


   __hetero_task_end(gen_shifted_task); 
   }

   {
    void* transpose_task = __hetero_task_begin(
         /* Num Inputs */ 2,
         shifted_matrix,   shifted_matrix_size,
         transposed_matrix,   transposed_matrix_size,
         /* Num Outputs */ 1,
         transposed_matrix,   transposed_matrix_size,
         "gen_tranpose_task");

    //std::cout << "Transpose Begin" <<std::endl;
	 *transposed_matrix = __hetero_hdc_matrix_transpose<N_FEATURES, D, hvtype>(*shifted_matrix, N_FEATURES, D);

    //std::cout << "Transpose Task End" <<std::endl;

   __hetero_task_end(transpose_task); 
   }


   __hetero_section_end(wrapper_section);

   __hetero_task_end(root_task); 

   __hetero_section_end(root_section);
}


template <int D, int K, int N_VEC, int N_FEATURES>
void encoding_and_inference_node(
/* Input buffers: 4*/ 
                __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, 
                __hypervector__<N_FEATURES, hvtype>* datapoint_vec_ptr, size_t datapoint_vec_size, // Features
                __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, 
                __hypermatrix__<K, D, hvtype>* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
                /* Local Vars: 2*/
                __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, 
                

                __hypervector__<K, SCORES_TYPE>* scores_ptr, size_t scores_size,

                __hypervector__<D, hvtype>* update_hv_ptr, size_t update_hv_size,  
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
        /* Input Buffers: 5 */  7, 
                                encoded_hv_ptr, encoded_hv_size, 
                                clusters_ptr, clusters_size, 
                                temp_clusters_ptr, temp_clusters_size, 
                                update_hv_ptr, update_hv_size,
                                labels, labels_size,
                                scores_ptr, scores_size,
        /* Parameters: 1 */     labels_index,
        /* Output Buffers: 1 */ 2, encoded_hv_ptr, encoded_hv_size, 
 labels, labels_size, 
        "clustering_task"  
    );

    clustering_node<D, K, N_VEC>(encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, temp_clusters_ptr, temp_clusters_size, scores_ptr, scores_size,  update_hv_ptr, update_hv_size, labels_index, labels, labels_size); 

    __hetero_task_end(clustering_task);

    __hetero_section_end(root_section);
    return;

}


// Dimensionality, Clusters, data point vectors, features per.
template <int D, int K, int N_VEC, int N_FEATURES>
void root_node( /* Input buffers: 4*/ 
                __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, 
                __hypervector__<N_FEATURES, hvtype>* datapoint_vec_ptr, size_t datapoint_vec_size, // Features
                __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, 
                __hypermatrix__<K, D, hvtype>* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
                /* Local Vars: 2*/
                __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, 
                

                __hypervector__<K, SCORES_TYPE>* scores_ptr, size_t scores_size,

                __hypervector__<D, hvtype>* update_hv_ptr, size_t update_hv_size,  
                /* Parameters: 2*/
                int labels_index, int convergence_threshold, // <- not used.
                /* Output Buffers: 2*/
                int* labels, size_t labels_size){

    void* root_section = __hetero_section_begin();


    
    // Re-encode each iteration.
    void* inference_task = __hetero_task_begin(
            /* Input Buffers:  */ 10, 
            rp_matrix_ptr, rp_matrix_size, 
            datapoint_vec_ptr,  datapoint_vec_size,
            clusters_ptr,  clusters_size, 
            temp_clusters_ptr,  temp_clusters_size, // ALSO AN OUTPUT
            encoded_hv_ptr, encoded_hv_size, 
            scores_ptr, scores_size,
            update_hv_ptr,  update_hv_size,  
            labels_index, convergence_threshold, // <- not used.
            labels,  labels_size,

            /* Output Buffers: 1 */ 2, 
            encoded_hv_ptr, encoded_hv_size,
            labels,  labels_size,
            "inference_task"  
            );

        encoding_and_inference_node<D, K, N_VEC>(
            rp_matrix_ptr, rp_matrix_size, 
            datapoint_vec_ptr,  datapoint_vec_size,
            clusters_ptr,  clusters_size, 
            temp_clusters_ptr,  temp_clusters_size, // ALSO AN OUTPUT
            encoded_hv_ptr, encoded_hv_size, 
            scores_ptr, scores_size,
            update_hv_ptr,  update_hv_size,  
            labels_index, convergence_threshold, // <- not used.
            labels,  labels_size
        );

    __hetero_task_end(inference_task);



    void* update_task = __hetero_task_begin(
        /* Input Buffers: 4 */  4, 
                                encoded_hv_ptr, encoded_hv_size, 
                                temp_clusters_ptr, temp_clusters_size, 
                                update_hv_ptr, update_hv_size,
                                labels, labels_size,
        /* Output Buffers: 1 */ 2,  
        labels, labels_size,
        temp_clusters_ptr, temp_clusters_size,
        "update_task"  
    );

    {

        *update_hv_ptr =  __hetero_hdc_get_matrix_row<K, D, hvtype>(*temp_clusters_ptr, K, D, *labels);
        *update_hv_ptr = __hetero_hdc_sum<D, hvtype>(*update_hv_ptr, *encoded_hv_ptr); // May need an instrinsic for this.
        __hetero_hdc_set_matrix_row<K, D, hvtype>(*temp_clusters_ptr, *update_hv_ptr, *labels); // How do we normalize?

    }

    __hetero_task_end(update_task);

    __hetero_section_end(root_section);
    return;
}




template <int D, int K, int N_VEC, int N_FEATURES>
void flattened_root( /* Input buffers: 4*/ 
                __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, 
                __hypervector__<N_FEATURES, hvtype>* datapoint_vec_ptr, size_t datapoint_vec_size, // Features
                __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, 
                __hypermatrix__<K, D, hvtype>* temp_clusters_ptr, size_t temp_clusters_size, // ALSO AN OUTPUT
                /* Local Vars: 2*/
                __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, 
                
                __hypervector__<K, hvtype>* scores_ptr, size_t scores_size,

                __hypervector__<D, hvtype>* update_hv_ptr, size_t update_hv_size,  // Used in second stage of clustering node for extracting and accumulating
                /* Parameters: 2*/
                int labels_index, int convergence_threshold, // <- not used.
                /* Output Buffers: 2*/
                int* labels, size_t labels_size){

    void* root_section = __hetero_section_begin();

    void* root_task = __hetero_task_begin(
        /* Input Buffers: 3*/ 10, encoded_hv_ptr, encoded_hv_size,
				 rp_matrix_ptr, rp_matrix_size,
				 datapoint_vec_ptr, datapoint_vec_size,
				 encoded_hv_ptr, encoded_hv_size,
				 clusters_ptr, clusters_size,
				 scores_ptr, scores_size,
				 labels, labels_size, 
				 temp_clusters_ptr, temp_clusters_size, 
				 update_hv_ptr, update_hv_size,
				 labels_index,
        /* Parameters: 0*/
        /* Output Buffers: 1*/4, encoded_hv_ptr, encoded_hv_size,
				 scores_ptr, scores_size,
				 labels, labels_size, 
				 temp_clusters_ptr, temp_clusters_size, 
        "root_task"
    );

    void* fpga_section = __hetero_section_begin();

    void* encoding_task = __hetero_task_begin(
        /* Input Buffers: 3*/ 3, rp_matrix_ptr, rp_matrix_size, 
				 datapoint_vec_ptr, datapoint_vec_size, 
				 encoded_hv_ptr, encoded_hv_size,
        /* Parameters: 0*/
        /* Output Buffers: 1*/ 1, encoded_hv_ptr, encoded_hv_size,
        "flattened_encoding_task"
    );
    {

        __hetero_hint(DEVICE);


        // Initialize matrix state with 0
        __hypervector__<D, hvtype> encoded_hv = __hetero_hdc_create_hypervector<D, hvtype>(0, (void*) zero_hv<hvtype>);
        *encoded_hv_ptr = encoded_hv;

        encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, hvtype>(*datapoint_vec_ptr, *rp_matrix_ptr); 
        *encoded_hv_ptr = encoded_hv;


    #ifdef HAMMING_DIST
    __hypervector__<D, int> bipolar_encoded_hv = __hetero_hdc_sign<D, int>(encoded_hv);
    *encoded_hv_ptr = bipolar_encoded_hv;
    #endif


    }
    __hetero_task_end(encoding_task); 


    void* clustering_task_1 = __hetero_task_begin(
        /* Input Buffers: 4*/ 3, encoded_hv_ptr, encoded_hv_size, 
				 clusters_ptr, clusters_size, 
				 scores_ptr, scores_size, 
        /* Output Buffers: 1*/ 1,  scores_ptr, scores_size, "flattened_clustering_scoring_task"
    );
    {

        //std::cout << "clustering task 1" << std::endl;
        __hetero_hint(DEVICE);

        __hypervector__<D, hvtype> encoded_hv = *encoded_hv_ptr;
        __hypermatrix__<K, D, hvtype> clusters = *clusters_ptr;

        __hypervector__<K, SCORES_TYPE> scores = *scores_ptr; // Precision of these scores might need to be increased.

#ifdef HAMMING_DIST
        *scores_ptr =  __hetero_hdc_hamming_distance<K, D, hvtype>(encoded_hv, clusters);
#else
        *scores_ptr = __hetero_hdc_cossim<K, D, hvtype>(encoded_hv, clusters);
#endif


    }
   __hetero_task_end(clustering_task_1);

   void* clustering_task_2 = __hetero_task_begin(
           /* Input Buffers: 5*/ 6, scores_ptr, scores_size, 
				    labels, labels_size, 
				    encoded_hv_ptr, encoded_hv_size, 
				    temp_clusters_ptr, temp_clusters_size, 
				    update_hv_ptr, update_hv_size,
           /* paramters: 1*/        labels_index,
           /* Output Buffers: 2*/2, temp_clusters_ptr, temp_clusters_size, 
				    labels, labels_size, "flattened_find_score_and_update_task"
           );
   {


       __hetero_hint(DEVICE);
       //std::cout << "clustering task 2" << std::endl;
       __hypervector__<K, hvtype> scores = *scores_ptr;
       int max_idx = 0;

       // IF using hamming distance:

#ifdef HAMMING_DIST
       hvtype max_score = (hvtype) D - (*scores_ptr)[0][0]; // I think this is probably causing issues.
#else
       hvtype max_score = (hvtype) (*scores_ptr)[0][0];
#endif

       for (int k = 0; k < K; k++) {
#ifdef HAMMING_DIST
           hvtype score = (hvtype) D - (*scores_ptr)[0][k];
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
       labels[labels_index] = max_idx;

       *update_hv_ptr =  __hetero_hdc_get_matrix_row<K, D, hvtype>(*temp_clusters_ptr, K, D, max_idx);
       *update_hv_ptr = __hetero_hdc_sum<D, hvtype>(*update_hv_ptr, *encoded_hv_ptr); // May need an instrinsic for this.
       __hetero_hdc_set_matrix_row<K, D, hvtype>(*temp_clusters_ptr, *update_hv_ptr, max_idx); // How do we normalize?


   }
   __hetero_task_end(clustering_task_2);

   __hetero_section_end(fpga_section);

   __hetero_task_end(root_task); 

   __hetero_section_end(root_section);
}
