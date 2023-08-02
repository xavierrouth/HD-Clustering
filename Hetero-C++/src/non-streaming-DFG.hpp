#pragma once

#include <hpvm_hdc.hpp>

#include <math.h>
#include <heterocc.h>
#include <stdlib.h>

// Some parameter macros overlap with the template parameters, so we have to undef them.

#undef D
#undef F
#undef Q
#undef N_REF
#undef N_QUERY
#undef N_VEC

#define HM_GET_ROW(N, type, hm, i) ((__hypervector__<N, type>*)&hm)[i]
#define HM_SET_ROW(N, type, hm, hv, i) ((__hypervector__<N, type>*)&hm)[i] = hv;

#define MAX_ITERATIONS 5

typedef int binary;

// RANDOM PROJECTION ENCODING!!
// Should literally just be matrix-vector mul, but iterated for each vector that needs to be encoded, so matrix-matrix mul is possible.
// Why is this different from the paper?? Can we use level-id encoding?
// Instead of encoding one HV at a time, parallel loop over all of them.
// RP encoding reduces N_features -> D (but D is bigger? What is the point?)
template<int D, int N_FEATURES, int N_VEC, typename elemTy>
void rp_encoding_node(/* Input Buffers: 2*/
        binary* rp_matrix, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
        int* datapoint_matrix, size_t datapoint_matrix_size, // __hypermatrix__<N_VEC, N_FEATURES, int> 
        /* Output Buffers: 1*/
        binary* encoded_hvs, size_t encoded_hvs_size) { // __hypermatrix__<N_VEC, D, binary>
    
    void* section = __hetero_section_begin();

    // To convert to streaming implementation, just remove the parallel loop and only provide one HV at a time.
    for (int i = 0; i < N_VEC; i++) {
        __hetero_parallel_loop(1,
        /* Input Buffers: 2*/ 3, rp_matrix, rp_matrix_size, datapoint_matrix, datapoint_matrix_size, encoded_hvs, encoded_hvs_size,
        /* Parameters: 0*/
        /* Output Buffers: 1*/ 1, encoded_hvs, encoded_hvs_size,
        "encoding_node_parallel_loop");

        __hypervector__<N_FEATURES, int> dp_vec = HM_GET_ROW(N_FEATURES, int, datapoint_matrix, i);
        __hypervector__<D, int> encoded_hv = __hetero_hdc_matmul<D, N_FEATURES, int>(dp_vec, *((__hypermatrix__<D, N_FEATURES, int>*)(rp_matrix))); 
        __hypervector__<D, binary> binarized_encoded_hv = __hetero_hdc_sign<D, int>(encoded_hv);

        // Data race??
        HM_SET_ROW(D, binary, encoded_hvs, binarized_encoded_hv, i);
    }

    __hetero_section_end(section);
    return;
}

// Paper description of clustering_node. May cause weird results when combined with random projection encoding instead of level-id.
#if 1
template<int D, int K, int N_VEC, typename elemTy> 
void clustering_node_iteration(/* Input Buffers: 1*/
        binary* encoded_hvs, size_t encoded_hvs_size, // __hypermatrix__ <NUM_VEC, D, elemTy>
        binary* clusters, size_t clusters_size, //__hypermatrix__<
        /* Output Buffers: 1*/
        int* labels, size_t labels_size) {

    void* section = __hetero_section_begin();

    /** Map HVs to Clusters*/
    // loop over all HVs, they each be done in parallel
    for (int j = 0; j < N_VEC; j++) {
        __hetero_parallel_loop(1,
        /* Input Buffers: 2*/ 3, encoded_hvs, encoded_hvs_size, clusters, clusters_size, labels, labels_size,
        /* Output Buffers: 1*/ 1, labels, labels_size,
        "clustering_iter_map_parallel_loop"
        ); 
            
        int min = D;
        int min_k = 0;
        __hypervector__<D, binary> hvec = HM_GET_ROW(D, binary, *((__hypermatrix__<N_VEC, D, binary>*)(encoded_hvs)), j);
        // Compute distance to each cluster center
        // Use vector-Matrix intrinsic as alternative to commented-out loop, however waste of a loop (over K) by not keeping track of min as we go.
        __hypervector__<K, int> distances =  __hetero_hdc_hamming_distance<K, D, binary>(hvec, *((__hypermatrix__<K, D, binary>*)clusters));
        for (int k = 0; k < K; k++) {
            if (distances[k] < min) {
                min = distances[k];
                min_k = k;
            }
        }

        labels[j] = min_k;

    } // End parallel loop, end HV to Cluster assignment.

    // Or we could double buffer clusters and just update them when assigning to groups.

    /** Update Cluster Centers*/
    for (int k = 0; k < K; k++) {
        __hetero_parallel_loop(1,
        /* Input Buffers: 2*/ 3, encoded_hvs, encoded_hvs_size, clusters, clusters_size, labels, labels_size,
        /* Output Buffers: 1*/ 1, clusters, clusters_size,
        "clustering_iter_update_parllel_loop"
        ); 
        __hypervector__<D, int> sum = {0};
        int cluster_elements = 0;
        // Must be a more efficient way to do this. See clustering implementation based on masks?
        for (int i = 0; i < N_VEC; i++) {
            if (labels[i] == k) {
                cluster_elements += 1;
                sum += HM_GET_ROW(D, elemTy, encoded_hvs, i);
            }
        }
        // reduce result to binary via majority with size of mask/2 as parameter.
        __hypervector__<D, binary> new_cluster = __hetero_hdc_sign<D, int>(sum); //__hetero_hdc_majority_binary<D, int>(sum, cluster_elements/2);
        HM_SET_ROW(D, binary, clusters, new_cluster, k);

    } // End parallel loop, end HV to Cluster assignment.
    
    __hetero_section_end(section);
    
    return;
}
#endif

// Manages looping over the clutsering operation.
// Encoding method does not matter
// Dimensionality, number, clusters, number vectors, encoding precision.
template<int D, int K, int N_VEC, typename elemTy>
void clustering_node(/* Input Buffers: 3*/
        binary* encoded_hvs, size_t encoded_hvs_size, // Encoded Hypervectors
        binary* clusters, size_t clusters_size, // Location of initial Clusters
        /* Parameters: 2*/
        //int max_iterations, int convergence_threshold,
        /* Output Buffers: 1*/
        int* labels, size_t labels_size) { // Mapping of HVs to Clusters. {
        
    for (int i = 0; i < MAX_ITERATIONS; i++) {
        void* section = __hetero_section_begin();

        // TODO: Split these into two tasks?
        void* cluster_task = __hetero_task_begin(
            /* Input Buffers: 3*/ 3, encoded_hvs, encoded_hvs_size, clusters, clusters_size, labels, labels_size, 
            /* Output Buffers: 1*/ 1, labels, labels_size
        );

        clustering_node_iteration<D, K, N_VEC, int>(encoded_hvs, encoded_hvs_size, clusters, clusters_size,labels, labels_size);

        __hetero_task_end(cluster_task);
        __hetero_section_end(section);
    }

    return;
}



template <int D, int K, int N_VEC, int N_FEATURES, typename elemTy>
void root_node( /* Input buffers: 2*/ 
                binary* rp_matrix, size_t rp_matrix_size, // __hypermatrix__<N_FEATURES, D, binary>
                int* datapoint_matrix, size_t datapoint_matrix_size, // __hypermatrix__<N_VEC, N_FEATURES, int> 
                /* Local Vars: 1*/
                binary* encoded_hvs, size_t encoded_hvs_size, // __hypermatrix__<N_VEC, D, binary>
                binary* clusters, size_t clusters_size, // __hypermatrix__<K, D, binary>
                /* Parameters: */
                /* Output Buffers: 1*/
                int* labels, size_t labels_size){
    void* section = __hetero_section_begin();

    void* encoding_task = __hetero_task_begin(
        /* Input Buffers: 3 */ 3, rp_matrix, rp_matrix_size, datapoint_matrix, datapoint_matrix_size, encoded_hvs, encoded_hvs_size,
        /* Output Buffers: 1 */ 1, encoded_hvs, encoded_hvs_size,
        "Root_Encoding_Task"  
    );

    rp_encoding_node<D, N_FEATURES, N_VEC, elemTy>(rp_matrix, rp_matrix_size, datapoint_matrix, datapoint_matrix_size, encoded_hvs, encoded_hvs_size);

    __hetero_task_end(encoding_task);
    void* initialize_clusters = __hetero_task_begin(
        /* Input Buffers: 2*/ 2, encoded_hvs, encoded_hvs_size, clusters, clusters_size,
        /* Output Buffers: 1*/ 1, clusters, clusters_size,
        "Initialize_Clusters_task"
    );
    
    // Initialize clusters, have to do it here.
    for (int k = 0; k < K; k++) {
        HM_GET_ROW(D, int, *((__hypermatrix__<K, D, binary>*)(clusters)), k) = HM_GET_ROW(D, int, *(__hypermatrix__<N_VEC, D, binary>*)encoded_hvs, k);
    }

    __hetero_task_end(initialize_clusters);

    void* clustering_task = __hetero_task_begin(
        /* Input Buffers: 2*/ 3, encoded_hvs, encoded_hvs_size, clusters, clusters_size, labels, labels_size,
        /* Output Buffers: 1*/ 1, labels, labels_size,
        "Root_Clustering_Task"
    );

    

    clustering_node<D, K, N_VEC, elemTy>(encoded_hvs, encoded_hvs_size, clusters, clusters_size, labels, labels_size);

    __hetero_task_end(clustering_task);

    __hetero_section_end(section);
    return;
}

// Optimized clustering node, using a temp buffer for cluster updates
// NOTE: uses hamming distance instead of dot product similarity?? cosine similarity? Not sure what is happening in the HD-Clustering FPGA.
// Just kidding, this probably needs to be the streaming version.
#if 0
template<int D, int K, int NUM_VEC, typename elemTy> 
void clustering_node_iteration(/* Input Buffers: 1*/
        binary* encoded_hvs, size_t encoded_hvs_size, // __hypermatrix__ <NUM_VEC, D, elemTy>
        binary* clusters, size_t clusters_size, // Double buffer clusters
        binary* clusters_temp, size_t clusters_t_size, // Double buffer clusters
        /* Output Buffers: 1*/
        int* labels, size_t labels_size) {

    void* section = __hetero_section_begin();


    /** Map HVs to Clusters*/
    // loop over all HVs, they each be done in parallel
    for (int j = 0; j < NUM_VEC; j++) {
        __hetero_parallel_loop(1,
        /* Input Buffers: 2*/ 3, encoded_hvs, encoded_hvs_size, clusters, clusters_size, labels, labels_size,
        /* Output Buffers: 1*/ 1, labels, labels_size,
        "clustering_iter_map_parllel_loop"
        ); 
            
        int min = D;
        int min_k = 0;
        __hypervector__<D, binary> hvec = HM_GET_ROW(D, binary, *((__hypermatrix__<NUM_VEC, D, binary>*)(encoded_hvs)), j);
        // Compute distance to each cluster center
        // Use vector-Matrix intrinsic as alternative to commented-out loop, however waste of a loop (over K) by not keeping track of min as we go.
        __hypervector__<K, int> distances =  __hetero_hdc_hamming_distance_binary<K, D, binary>(hvec, clusters);
        for (int k = 0; k < K; k++) {
            if (distances[k] < min) {
                min = distances[k];
                min_k = k;
            }
        }

        labels[j] = min_k;

        // Data race, multiple threads summing to same thing.
        // We can only do this if we use streaming I guess.
        cluster_temp


    } // End parallel loop, end HV to Cluster assignment.

    // Or we could double buffer clusters and just update them when assigning to groups.

    /** Update Cluster Centers*/
    for (int k = 0; k < K; k++) {
        __hetero_parallel_loop(1,
        /* Input Buffers: 2*/ 3, encoded_hvs, encoded_hvs_size, clusters_1, clusters_1_size, labels, labels_size,
        /* Output Buffers: 1*/ 1, clusters_1, clusters_1_size,
        "clustering_iter_update_parllel_loop"
        ); 
        __hypervector__<D, int> sum = {0};
        int cluster_elements = 0;
        // Must be a more efficient way to do this. See clustering implementation based on masks?
        for (int i = 0; i < NUM_VEC; i++) {
            if (labels[i] == k) {
                cluster_elements += 1;
                sum += HM_GET_ROW(D, elemTy, encoded_hvs, i);
            }
        }
        // reduce result to binary via majority with size of mask/2 as parameter.
        __hypervector__<D, binary> new_cluster =__hetero_hdc_majority_binary<D, int>(sum, cluster_elements/2);
        HM_SET_ROW(D, binary, clusters, new_cluster, k);

    } // End parallel loop, end HV to Cluster assignment.
    
    __hetero_section_end(section);
    
    return;
}
#endif


#if 0
// elemTy should be 'binary (bool)' I suppose it is int.
// implementation using cluster_mask
// does clustering and search.
template<int D, int K, int NUM_VEC, typename elemTy> 
void clustering_node(/* Input Buffers: 1*/
        elemTy* encoded_hvs_ptr, size_t encoded_hvs_size,
        binary* clusters_ptr, size_t clusters_size,
        /* Parameters: 2*/
        int max_iterations, int convergence_threshold,
        /* Output Buffers: 1*/
        binary* cluster_masks_ptr, size_t cluster_masks_size) {

    __hypermatrix__<NUM_VEC, D, elemTy> encoded_hvs = *encoded_hvs_ptr;
    /* Should this be moved outside the node?*/
    // Data dependencies, can not be parallelized. 
    for (int i = 0; i < max_iterations; i++) {
        void* section = __hetero_section_begin();

        // This needs to be initialized to 0.
        __hypermatrix__<K, NUM_VEC, binary> cluster_masks; // Binary precision bitmask, one for each cluster. For a mask k, if index i is 1, then hv i belongs to cluster k.
        
        __hypervector__<D, int> cluster_sum;
        __hypermatrix__<D, K, binary> clusters; // Binary precision // Choose initial clusters somehow, either in the DFG before any iterations, or on the device.
        
        /** Map HVs to Clusters*/
        // loop over all HVs, they each be done in parallel
        for (int j = 0; j < NUM_VEC; j++) {
            __hetero_parallel_loop(); //Inputs: Clusters, encoded_hvs //Outputs: cluster_mask,
                
            int min = D;
            int min_k = 0;
            __hypervector__<D, binary> hvec = HM_GET_ROW(D, elemTy, (*encoded_hvs), j);
            // Compute distance to each cluster center
            // Use vector-Matrix intrinsic as alternative to commented-out loop, however waste of a loop (over K) by not keeping track of min as we go.
            __hypervector__<K, int> distances =  __hetero_hdc_hamming_distance<K, D, int>(hvec, clusters);
            for (int k = 0; k < K; k++) {
                if (distances[k] < min) {
                    min = distances[k];
                    min_k = k;
                }
            }
            /** Other Option:
            for (int k = 0; k < K; k++) {
                __hypervector__<D, binary> cluster = HM_GET_ROW(D, binary, clusters, k)
                int dist = __hetero_hdc_hamming_distance<>(cluster, hvec);
                if (dist < min) {
                    min = dist;
                    min_k = k;
                }
            }
            */

            // Set the bit representing this HV to true in the cluster bitmask.
            HM_GET_ROW(NUM_VEC, binary, cluster_mask, min_k)[j] = 1;

        } // End parallel loop, end HV to Cluster assignment.

        /** Update Cluster Centers*/

        // Need to keep track of amt cluster changes, for termination condition.

        // This can be a sum of all cluster changes, and then test if it is below threshold. can't because we will have data race w/o atomics. 

        // Can store all previous clusters, and all current clusters, and then parallel loop over them and if any of them have changed by a significant amt then we continue.
        // We have to double buffer clusters then, which is expensive?
        
        for (int k = 0; k < K; k++) {
            __hetero_parallel_loop(); //Inputs: cluster_mask, clusters, encoded_hv //Outputs: cluster_mask,
            //__hypervector__<D, binary> previous_cluster = HM_GET_ROW(D, binary, clusters, k); // Before change
            // Multiply encoded hvs with mask, // can't actually do this.
            __hypervector__<D, int> sum = {0};
            __hypervector__<NUM_VEC, binary> mask = HM_GET_ROW(NUM_VEC, binary, cluster_mask, k)
            int cluster_size = 0;
            for (int i = 0; i < NUM_VEC; i++) {
                // Really Not Ideal // sum results,
                cluster_size += mask[i];
                sum += HM_GET_ROW(D, elemTy, encoded_hvs, i) * mask[i];
            }
            // reduce result to binary via majority with size of mask/2 as parameter.
            __hypervector__<D, binary> new_cluster =__hetero_hdc_majority_binary<D, int>(sum, cluster_size/2);
            HM_SET_ROW(D, binary, clusters, new_cluster, k);

        } // End parallel loop, end HV to Cluster assignment.
        
        

        __hetero_section_end(section);

        // Implement This Later:
        if (0 > convergence_threshold)
            break;

        // Does this get synced??
    }
    
    return;
}

#endif