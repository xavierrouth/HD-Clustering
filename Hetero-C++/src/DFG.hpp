#include <hpvm_hdc.h>
#include <iostream>
#include <heterocc.h>

#define HAMMING_DIST

typedef int hvtype;

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
T zero_hv(size_t loop_index_var) { return 0; }

// Need multiple copies because of HPVM limitations, so add unused template parameter.
template<int D, int N_FEATURES, int unused>
void rp_encoding_node(/* Input Buffers: 2*/ __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, __hypervector__<N_FEATURES, hvtype>* input_datapoint_ptr, size_t input_datapoint_size, /* Output Buffers: 1*/ __hypervector__<D, hvtype>* output_hv_ptr, size_t output_hv_size) {
    
#ifndef NODFG
    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(/* Input Buffers: 2*/ 3, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size, /* Parameters: 0*/ /* Output Buffers: 1*/ 1, output_hv_ptr, output_hv_size, "inner_rp_encoding_task");

    //__hetero_hint(DEVICE);
#endif
    

    __hypervector__<D, hvtype> encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, hvtype>(*input_datapoint_ptr, *rp_matrix_ptr); 
    // Uses the output_hv_ptr for the buffer. So that we can lower to 
    // additional tasks. We should do an optimization in the bufferization
    // analysis to re-use the same buffer (especially those coming from the
    // formal parameters) to enable more of these tasks to become parallel loops.
    *output_hv_ptr = encoded_hv;
    
    #ifdef HAMMING_DIST
    __hypervector__<D, hvtype> bipolar_encoded_hv = __hetero_hdc_sign<D, hvtype>(encoded_hv);
    *output_hv_ptr = bipolar_encoded_hv;
    #endif

#ifndef NODFG
    __hetero_task_end(task); 

    __hetero_section_end(section);
#endif
    return;
}

// RP encoding reduces N_features -> D 
template<int D, int N_FEATURES>
void  InitialEncodingDAG(/* Input Buffers: 2*/ __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, __hypervector__<N_FEATURES, hvtype>* input_datapoint_ptr, size_t input_datapoint_size, /* Output Buffers: 1*/ __hypervector__<D, hvtype>* output_hv_ptr, size_t output_hv_size) {
    
#ifndef NODFG
    void* section = __hetero_section_begin();

    void* task = __hetero_task_begin(/* Input Buffers: 2*/ 3, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size, /* Parameters: 0*/ /* Output Buffers: 1*/ 1, output_hv_ptr, output_hv_size, "initial_encoding_wrapper");
#endif

    // Specifies that the following node is performing an HDC Encoding step
    __hetero_hdc_encoding(6, (void*)  rp_encoding_node<D, N_FEATURES, 0>, rp_matrix_ptr, rp_matrix_size, input_datapoint_ptr, input_datapoint_size, output_hv_ptr, output_hv_size);

#ifndef NODFG
    __hetero_task_end(task); 
    __hetero_section_end(section);
#endif
}

// clustering_node is the hetero-c++ version of searchUnit from the original FPGA code.
// It pushes some functionality to the loop that handles the iterations.
// For example, updating the cluster centers is not done here.
// Initializing the centroids is not done here.
// Node gets run max_iterations times.
// Dimensionality, number of clusters, number of vectors


// In the streaming implementation, this runs for each encoded HV, so N_VEC * EPOCHs times.
template<int D, int K, int N_VEC>
void __attribute__ ((noinline)) clustering_node(/* Input Buffers: 3*/ __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, __hypervector__<K, SCORES_TYPE>* scores_ptr, size_t scores_size, /* Output Buffers: 1*/ int* labels, size_t labels_size) { // Mapping of HVs to Clusters. int[N_VEC]

#ifndef NODFG
    void* section = __hetero_section_begin();
#endif

    { // Scoping hack in order to have 'scores' defined in each task.
    
#ifndef NODFG
    void* task1 = __hetero_task_begin(/* Input Buffers: 4*/ 3, encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, scores_ptr, scores_size, /* Output Buffers: 1*/ 1,  scores_ptr, scores_size, "clustering_scoring_task");

    __hetero_hint(DEVICE);
#endif

    __hypervector__<D, hvtype> encoded_hv = *encoded_hv_ptr;
    __hypermatrix__<K, D, hvtype> clusters = *clusters_ptr;

    __hypervector__<K, SCORES_TYPE> scores = *scores_ptr; // Precision of these scores might need to be increased.

    #ifdef HAMMING_DIST
    *scores_ptr =  __hetero_hdc_hamming_distance<K, D, hvtype>(encoded_hv, clusters);
    #else
#ifndef ACCEL
    *scores_ptr = __hetero_hdc_cossim<K, D, hvtype>(encoded_hv, clusters);
#endif
    #endif

#ifndef NODFG
   __hetero_task_end(task1);
#endif
    }
    
    {
#ifndef NODFG
   void* task2 = __hetero_task_begin(/* Input Buffers: 1*/ 3, encoded_hv_ptr, encoded_hv_size, scores_ptr, scores_size, labels, labels_size, /* Output Buffers: 1*/ 2, encoded_hv_ptr, encoded_hv_size, labels, labels_size, "find_score_and_label_task");

    __hetero_hint(DEVICE);
#endif
    
    __hypervector__<K, SCORES_TYPE> scores = *scores_ptr;
    int max_idx = 0;


#ifdef HAMMING_DIST
    max_idx = __hetero_hdc_arg_min<K, SCORES_TYPE>(*scores_ptr);
#else
    max_idx = __hetero_hdc_arg_max<K, SCORES_TYPE>(*scores_ptr);
#endif
    // Write labels
    //labels[encoded_hv_idx] = max_idx;
    *labels = max_idx;

#ifndef NODFG
    __hetero_task_end(task2);
#endif
    }
#ifndef NODFG
    __hetero_section_end(section);
#endif
    return;
}




// RP Matrix Node Generation. Performs element wise rotation on ID matrix rows and stores into destination buffer.
template <int D,  int N_FEATURES>
void gen_rp_matrix(/* Input Buffers*/ __hypervector__<D, hvtype>* rp_seed_vector, size_t  rp_seed_vector_size, __hypervector__<D, hvtype>* row_buffer, size_t  row_buffer_size, __hypermatrix__<N_FEATURES, D, hvtype>* shifted_matrix, size_t  shifted_matrix_size, __hypermatrix__<D, N_FEATURES, hvtype>* transposed_matrix, size_t  transposed_matrix_size){

#ifndef NODFG
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
#endif

    {
#ifndef NODFG
    void* gen_shifted_task = __hetero_task_begin(
         /* Num Inputs */ 3,
         rp_seed_vector,   rp_seed_vector_size,
         shifted_matrix,   shifted_matrix_size,
         row_buffer, row_buffer_size,
         /* Num Outputs */ 1,
         shifted_matrix,   shifted_matrix_size,
         "gen_shifted_matrix_task");

    //__hetero_hint(DEVICE);
#endif

	// Each row is just a wrap shift of the seed.
	for (int i = 0; i < N_FEATURES; i++) {
		__hypervector__<D, hvtype>  row = __hetero_hdc_wrap_shift<D, hvtype>(*rp_seed_vector, i);
        // *row_buffer = row;
        __hetero_hdc_set_matrix_row<N_FEATURES, D, hvtype>(*shifted_matrix, row, i);
	} 

#ifndef NODFG
   __hetero_task_end(gen_shifted_task); 
#endif
   }

   {
#ifndef NODFG
    void* transpose_task = __hetero_task_begin(/* Num Inputs */ 2, shifted_matrix,   shifted_matrix_size, transposed_matrix,   transposed_matrix_size, /* Num Outputs */ 1, transposed_matrix,   transposed_matrix_size, "gen_tranpose_task");

    //__hetero_hint(DEVICE);
#endif

	 *transposed_matrix = __hetero_hdc_matrix_transpose<N_FEATURES, D, hvtype>(*shifted_matrix, N_FEATURES, D);

#ifndef NODFG
   __hetero_task_end(transpose_task); 
#endif
   }

#ifndef NODFG
   __hetero_section_end(wrapper_section);

   __hetero_task_end(root_task); 

   __hetero_section_end(root_section);
#endif
}


template <int D, int K, int N_VEC, int N_FEATURES>
void encoding_and_inference_node(/* Input buffers: 4*/ __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, __hypervector__<N_FEATURES, hvtype>* datapoint_vec_ptr, size_t datapoint_vec_size, __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, int* labels, size_t labels_size, /* Local Vars: 2*/ __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, __hypervector__<K, SCORES_TYPE>* scores_ptr, size_t scores_size){
#ifndef NODFG
    void* root_section = __hetero_section_begin();
    
    // Re-encode each iteration.
    void* encoding_task = __hetero_task_begin(/* Input Buffers: 3 */ 3, rp_matrix_ptr, rp_matrix_size, datapoint_vec_ptr, datapoint_vec_size, encoded_hv_ptr, encoded_hv_size, /* Output Buffers: 1 */ 1, encoded_hv_ptr, encoded_hv_size, "encoding_task");
#endif

    rp_encoding_node<D, N_FEATURES, 1>(rp_matrix_ptr, rp_matrix_size, datapoint_vec_ptr, datapoint_vec_size, encoded_hv_ptr, encoded_hv_size);

#ifndef NODFG
    __hetero_task_end(encoding_task);

    void* clustering_task = __hetero_task_begin(/* Input Buffers: 5 */  4, encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, labels, labels_size, scores_ptr, scores_size, /* Output Buffers: 1 */ 2, encoded_hv_ptr, encoded_hv_size, labels, labels_size, "clustering_task");
#endif

    clustering_node<D, K, N_VEC>(encoded_hv_ptr, encoded_hv_size, clusters_ptr, clusters_size, scores_ptr, scores_size,  labels, labels_size); 

#ifndef NODFG
    __hetero_task_end(clustering_task);

    __hetero_section_end(root_section);
#endif

}


// Dimensionality, Clusters, data point vectors, features per.
template <int D, int K, int N_VEC, int N_FEATURES>
void root_node( /* Input buffers: 3*/ __hypermatrix__<D, N_FEATURES, hvtype>* rp_matrix_ptr, size_t rp_matrix_size, __hypervector__<N_FEATURES, hvtype>* datapoint_vec_ptr, size_t datapoint_vec_size, __hypermatrix__<K, D, hvtype>* clusters_ptr, size_t clusters_size, /* Output Buffers: 2*/ int* labels, size_t labels_size, /* Local Vars: 2*/ __hypervector__<D, hvtype>* encoded_hv_ptr, size_t encoded_hv_size, __hypervector__<K, SCORES_TYPE>* scores_ptr, size_t scores_size){

#ifndef NODFG
    void* root_section = __hetero_section_begin();
    
    // Re-encode each iteration.
    void* inference_task = __hetero_task_begin(/* Input Buffers:  */ 6, rp_matrix_ptr, rp_matrix_size, datapoint_vec_ptr,  datapoint_vec_size, clusters_ptr,  clusters_size, labels,  labels_size, encoded_hv_ptr, encoded_hv_size, scores_ptr, scores_size, /* Output Buffers: 1 */ 2, encoded_hv_ptr, encoded_hv_size, labels,  labels_size, "inference_task"  );
#endif

    __hetero_hdc_inference( /* Num Formal Parameters */ 14, (void*) encoding_and_inference_node<D, K, N_VEC, N_FEATURES>, rp_matrix_ptr, rp_matrix_size, datapoint_vec_ptr,  datapoint_vec_size, clusters_ptr,  clusters_size,  labels,  labels_size, encoded_hv_ptr, encoded_hv_size, scores_ptr, scores_size);
    
#ifndef NODFG
    __hetero_task_end(inference_task);
    __hetero_section_end(root_section);
#endif
    return;
}
