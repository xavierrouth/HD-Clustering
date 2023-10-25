#define HPVM 1

#ifdef HPVM
#include <heterocc.h>
#include <hpvm_hdc.h>
#include "DFG.hpp"
#endif
#include "host.h"
#include <vector>
#include <cassert>
#include <cmath>


#define HAMMING_DIST
#define OFFLOAD_RP_GEN


#ifdef HAMMING_DIST
#define SCORES_TYPE hvtype
#else
#define SCORES_TYPE float
#endif


#define DUMP(vec, suffix) {\
  FILE *f = fopen("dump/" #vec suffix, "w");\
  if (f) fwrite(vec.data(), sizeof(vec[0]), vec.size(), f);\
  if (f) fclose(f);\
}

template <int N, typename elemTy>
void inline print_hv(__hypervector__<N, elemTy> hv) {
    // TEMPORARILY DISABLED AS THIS CALL BREAKS Code
    return;
    std::cout << "[";
    for (int i = 0; i < N-1; i++) {
        std::cout << hv[0][i] << ", ";
    }
    std::cout << hv[0][N-1] << "]\n";
    return;
}

void datasetBinaryRead(std::vector<int> &data, std::string path){
	std::ifstream file_(path, std::ios::in | std::ios::binary);
	assert(file_.is_open() && "Couldn't open file!");
	int32_t size;
	file_.read((char*)&size, sizeof(size));
	int32_t temp;
	for(int i = 0; i < size; i++){
		file_.read((char*)&temp, sizeof(temp));
		data.push_back(temp);
	}
	file_.close();
}
template <typename T>
T initialize_hv(T* datapoint_vector, size_t loop_index_var) {
	//std::cout << ((float*)datapoint_vector)[loop_index_var] << "\n";
	return datapoint_vector[loop_index_var];
}

template <typename T>
T initialize_rp_seed(size_t loop_index_var) {
	int i = loop_index_var / 32;
	int j = loop_index_var % 32;

	//std::cout << i << " " << j << "\n";
	long double temp = log2(i+2.5) * pow(2, 31);
	long long int temp2 = (long long int)(temp);
	temp2 = temp2 % 2147483648;
	//temp2 = temp2 % int(pow(2, 31));
	//2147483648;

	int ele = temp2 & (0x01 << j); //temp2 && (0x01 << j);

	//std::cout << ele << "\n";

	if (ele) {
		return (T) 1;
	}
	else {
		return (T) -1;
	}
}


int main(int argc, char** argv)
{
	__hpvm__init();

	auto t_start = std::chrono::high_resolution_clock::now();
	std::cout << "Main Starting" << std::endl;

	srand(time(NULL));






    assert(argc == 2 && "Expected parameter");
	int EPOCH = std::atoi(argv[1]);
   
	std::vector<int> X_data;
	std::vector<int> y_data;
	datasetBinaryRead(X_data, X_data_path);
	datasetBinaryRead(y_data, y_data_path);

	std::cout << "Read Data Starting" << std::endl;
	int shuffle_arr[y_data.size()];
	//srand (time(NULL));
	
	srand(0);
	// Does this shuffle features within a datapoint or datapoints within every entry.
	if(shuffled){
		std::vector<int> X_data_shuffled(X_data.size());
		std::vector<int> y_data_shuffled(y_data.size());
		for(int i = 0; i < y_data.size(); i++)
			shuffle_arr[i] = i;
		//shuffle
		for(int i = y_data.size()-1; i != 0; i--){
			int j = rand()%i;
			int temp = shuffle_arr[i];
			shuffle_arr[i] = shuffle_arr[j];
			shuffle_arr[j] = temp;  
		}

		for(int i = 0; i < y_data.size(); i++){
			y_data_shuffled[i] = y_data[shuffle_arr[i]];
			for(int j = 0; j < N_FEAT; j++){
				X_data_shuffled[i*N_FEAT + j] = X_data[shuffle_arr[i]*N_FEAT + j];
			}
		}
		X_data = X_data_shuffled;
		y_data = y_data_shuffled;
	}	
	
	assert(N_SAMPLE == y_data.size());
	
	std::vector<hvtype> floatVec(X_data.begin(), X_data.end());

	hvtype* input_vectors = floatVec.data();
	// N_FEAT is number of entries per vector
	size_t input_vector_size = N_FEAT * sizeof(hvtype); // Size of a single vector

	int labels[N_SAMPLE]; // Does this need to be malloced?
	// N_SAMPLE is number of input vectors
	size_t labels_size = N_SAMPLE * sizeof(int);

	auto t_elapsed = std::chrono::high_resolution_clock::now() - t_start;
	long mSec = std::chrono::duration_cast<std::chrono::milliseconds>(t_elapsed).count();
	long mSec1 = mSec;
	std::cout << "Reading data took " << mSec << " mSec" << std::endl;

	t_start = std::chrono::high_resolution_clock::now();

	// Host allocated memory 
	__hypervector__<Dhv, hvtype> encoded_hv = __hetero_hdc_hypervector<Dhv, hvtype>();
	hvtype* encoded_hv_buffer = new hvtype[Dhv];
	*((__hypervector__<Dhv, hvtype>*) encoded_hv_buffer) = encoded_hv;
	size_t encoded_hv_size = Dhv * sizeof(hvtype);


	hvtype* update_hv_ptr = new hvtype[Dhv];
	size_t update_hv_size = Dhv * sizeof(hvtype);
	
	// Used to store a temporary cluster for initializion
	__hypervector__<Dhv, hvtype> cluster = __hetero_hdc_hypervector<Dhv, hvtype>();
	hvtype* cluster_buffer = new hvtype[Dhv];
	size_t cluster_size = Dhv * sizeof(hvtype);

	// Read from during clustering, updated from clusters_temp.
	__hypermatrix__<N_CENTER, Dhv, hvtype> clusters = __hetero_hdc_hypermatrix<N_CENTER, Dhv, hvtype>();
	hvtype* clusters_buffer = new hvtype[N_CENTER * Dhv];
	size_t clusters_size = N_CENTER * Dhv * sizeof(hvtype);

	// Gets written into during clustering, then is used to update 'clusters' at the end.
	__hypermatrix__<N_CENTER, Dhv, hvtype> clusters_temp = __hetero_hdc_hypermatrix<N_CENTER, Dhv, hvtype>();
	hvtype* clusters_temp_buffer = new hvtype[N_CENTER * Dhv];

	// Temporarily store scores, allows us to split score calcuation into a separte task.


	__hypervector__<Dhv, SCORES_TYPE> scores = __hetero_hdc_hypervector<Dhv, SCORES_TYPE>();
	SCORES_TYPE* scores_buffer = new SCORES_TYPE[N_CENTER];
	size_t scores_size = N_CENTER * sizeof(SCORES_TYPE);







	size_t rp_matrix_size = N_FEAT * Dhv * sizeof(hvtype);


	__hypervector__<Dhv, hvtype> rp_seed = __hetero_hdc_create_hypervector<Dhv, hvtype>(0, (void*) initialize_rp_seed<hvtype>);	

	std::cout << "Dimension over 32: " << Dhv/32 << std::endl;
	//We need a seed ID. To generate in a random yet determenistic (for later debug purposes) fashion, we use bits of log2 as some random stuff.

	std::cout << "Seed hv:\n";
	std::cout << "After seed generation\n";

	// Dhv needs to be greater than N_FEAT for the orthognality to hold.

#ifdef OFFLOAD_RP_GEN

	hvtype* rp_matrix_buffer = new hvtype[N_FEAT * Dhv];
	hvtype* shifted_buffer = new hvtype[N_FEAT * Dhv];
	hvtype* row_buffer = new hvtype[Dhv];

    void* GenRPMatDAG = __hetero_launch(
        (void*) gen_rp_matrix<Dhv,  N_FEAT>,
        4,
        /* Input Buffers: 3*/ 
        &rp_seed, sizeof(hvtype) * Dhv,
        row_buffer, sizeof(hvtype) * Dhv,
        shifted_buffer, sizeof(hvtype) * (N_FEAT * Dhv),
        rp_matrix_buffer, sizeof(hvtype) * (N_FEAT * Dhv),
        /* Output Buffers: 1*/ 
        1,
        rp_matrix_buffer, sizeof(hvtype) * (N_FEAT * Dhv)
    );

    __hetero_wait(GenRPMatDAG);

    free(shifted_buffer);
    free(row_buffer);



    //rp_matrix =   *  (__hypermatrix__<Dhv, N_FEAT, hvtype>*) rp_matrix_buffer;

#else
	// Generate the random projection matrix. Dhv rows, N_FEAT cols, so Dhv x N_FEAT.
	__hypervector__<Dhv, hvtype> row = __hetero_hdc_hypervector<Dhv, hvtype>();
    __hypermatrix__<N_FEAT, Dhv, hvtype> rp_matrix_transpose = __hetero_hdc_hypermatrix<N_FEAT, Dhv, hvtype>();


	// Each row is just a wrap shift of the seed.
	for (int i = 0; i < N_FEAT; i++) {
		row = __hetero_hdc_wrap_shift<Dhv, hvtype>(rp_seed, i);
		__hetero_hdc_set_matrix_row<N_FEAT, Dhv, hvtype>(rp_matrix_transpose, row, i);
	} 

	// Now transpose in order to be able to multiply with input hv in DFG.
	__hypermatrix__<Dhv, N_FEAT, hvtype> rp_matrix = __hetero_hdc_matrix_transpose<N_FEAT, Dhv, hvtype>(rp_matrix_transpose, N_FEAT, Dhv);

    auto rp_matrix_buffer = &rp_matrix;
#endif




	// Initialize cluster hvs.
	std::cout << "Init cluster hvs:" << std::endl;
	for (int k = 0; k < N_CENTER; k++) {
		__hypervector__<N_FEAT, hvtype> datapoint_hv = __hetero_hdc_create_hypervector<N_FEAT, hvtype>(1, (void*) initialize_hv<hvtype>, input_vectors + k * N_FEAT_PAD);
		//hvtype* datapoint_hv_buffer = new hvtype[N_FEAT];
		//*((__hypervector__<N_FEAT, hvtype> *) datapoint_hv_buffer) = datapoint_hv;
		// Encode the first N_CENTER hypervectors and set them to be the clusters.

		void* initialize_DFG = __hetero_launch(
			//(void*) InitialEncodingDAG<Dhv, N_FEAT>,
			(void*) rp_encoding_node_copy<Dhv, N_FEAT>,
			2 + 1,
			/* Input Buffers: 2*/ 
            rp_matrix_buffer, rp_matrix_size,
			&datapoint_hv, input_vector_size,
			/* Output Buffers: 1*/ 
			&cluster, cluster_size,  //false,
			1,
			&cluster, cluster_size //false
		);

		__hetero_wait(initialize_DFG);


		// rp_encoding_node encodes a single cluster, which we then have to assign to our big group of clusters in cluster[s].
		// Note cluster vs clusters
		std::cout <<" Cluter "<< k << "\n";
        print_hv<Dhv, hvtype>(cluster);
		__hetero_hdc_set_matrix_row<N_CENTER, Dhv, hvtype>(clusters, cluster, k);
		__hypervector__<Dhv, hvtype> cluster_temp = __hetero_hdc_get_matrix_row<N_CENTER, Dhv, hvtype>(clusters, N_CENTER, Dhv, k);
	}

	std::cout << "\nDone init cluster hvs:" << std::endl;

	#if DEBUG
	for (int i = 0; i < N_CENTER; i++) {
		__hypervector__<Dhv, hvtype> cluster_temp = __hetero_hdc_get_matrix_row<N_CENTER, Dhv, hvtype>(clusters, N_CENTER, Dhv, i);
		std::cout << i << " ";
		print_hv<Dhv, hvtype>(cluster_temp);
	}
	#endif

	for (int i = 0; i < EPOCH; i++) {
		// Can we normalize the hypervectors here or do we have to do that in the DFG.
		std::cout << "Epoch: #" << i << std::endl;
		for (int j = 0; j < N_SAMPLE; j++) {

			__hypervector__<N_FEAT, hvtype> datapoint_hv = __hetero_hdc_create_hypervector<N_FEAT, hvtype>(1, (void*) initialize_hv<hvtype>, input_vectors + j * N_FEAT_PAD);

			// Root node is: Encoding -> Clustering for a single HV.
			void *DFG = __hetero_launch(
#ifdef FPGA
				(void*) flattened_root<Dhv, N_CENTER, N_SAMPLE, N_FEAT>,

#else
				(void*) root_node<Dhv, N_CENTER, N_SAMPLE, N_FEAT>,
#endif

				/* Input Buffers: 4*/ 10,
				rp_matrix_buffer, rp_matrix_size, //false,
				&datapoint_hv, input_vector_size, //true,
				&clusters, clusters_size, //false,
				&clusters_temp, clusters_size, //false,
				/* Local Var Buffers 4*/
				encoded_hv_buffer, encoded_hv_size,// false,
				scores_buffer, scores_size,
                update_hv_ptr, update_hv_size,
				j, 0, 
				/* Output Buffers: 1*/ 
				labels, labels_size,
				2,
				labels, labels_size,//, false
				&clusters_temp, clusters_size
			);
			__hetero_wait(DFG); 

			//std::cout << "after root launch" << std::endl;
		
		}
		// then update clusters and copy clusters_tmp to clusters, 

		// TODO: Move to DAG
		std::cout << "after root node\n";
		
		// TODO: Just swap pointers?? 
		for (int k = 0; k < N_CENTER; k++) {
			// set temp_clusters -> clusters
			__hypervector__<Dhv, hvtype> cluster_temp = __hetero_hdc_get_matrix_row<N_CENTER, Dhv, hvtype>(clusters_temp, N_CENTER, Dhv, k);

			#ifdef HAMMING_DIST
			__hypervector__<Dhv, hvtype> cluster_norm = __hetero_hdc_sign<Dhv, hvtype>(cluster_temp);
			__hetero_hdc_set_matrix_row(clusters, cluster_norm, k);
			#else
			__hetero_hdc_set_matrix_row(clusters, cluster_temp, k);
			#endif
		} 

		std::cout << "Printing 23rd cluster " << std::endl;
		for (int i = 0; i < N_CENTER; i++) {
			if (i == 23) {
				__hypervector__<Dhv, hvtype> cluster_temp = __hetero_hdc_get_matrix_row<N_CENTER, Dhv, hvtype>(clusters, N_CENTER, Dhv, i);
				std::cout << i << " ";
				print_hv<Dhv, hvtype>(cluster_temp);
			}
			
		}
	}


	t_elapsed = std::chrono::high_resolution_clock::now() - t_start;
	
	mSec = std::chrono::duration_cast<std::chrono::milliseconds>(t_elapsed).count();
	

	std::cout << "\nReading data took " << mSec1 << " mSec" << std::endl;    
	std::cout << "Execution (" << EPOCH << " epochs)  took " << mSec << " mSec" << std::endl;
	
	std::ofstream myfile("out.txt");
	for(int i = 0; i < N_SAMPLE; i++){
		myfile << y_data[i] << " " << labels[i] << std::endl;
	}
	__hpvm__cleanup();
	return 0;
}




