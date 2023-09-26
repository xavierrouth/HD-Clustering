#define HPVM 1

#ifdef HPVM
#include <heterocc.h>
#include <iostream>
#include <hpvm_hdc.h>
#include "DFG.hpp"
#endif
#include "host.h"
#include <vector>
#include <cassert>
#include <cmath>

#define DUMP(vec, suffix) {\
  FILE *f = fopen("dump/" #vec suffix, "w");\
  if (f) fwrite(vec.data(), sizeof(vec[0]), vec.size(), f);\
  if (f) fclose(f);\
}

template <int N, typename elemTy>
void print_hv(__hypervector__<N, elemTy> hv) {
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

int initialize_hv(int* datapoint_vector, size_t loop_index_var) {
	//std::cout << ((float*)datapoint_vector)[loop_index_var] << "\n";
	return datapoint_vector[loop_index_var];
}

int initialize_rp_seed(size_t loop_index_var) {
	int i = loop_index_var / 32;
	int j = loop_index_var % 32;

	//std::cout << i << " " << j << "\n";
	long double temp = log2(i+2.5) * pow(2, 31);
	long long int temp2 = (long long int)(temp);
	//temp2 = temp2 % 2147483648;
	temp2 = temp2 % 2147483648;

	int ele = temp2 & (0x01 << j); //temp2 && (0x01 << j);

	//std::cout << ele << "\n";

	if (ele) {
		return 1;
	}
	else {
		return -1;
	}
}


int main(int argc, char** argv)
{
	__hpvm__init();

	auto t_start = std::chrono::high_resolution_clock::now();
	std::cout << "Main Starting" << std::endl;

	srand(time(NULL));
   
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
	 
	int* input_vectors = X_data.data();
	// N_FEAT is number of entries per vector
	size_t input_vector_size = N_FEAT * sizeof(int); // Size of a single vector

	int labels[N_SAMPLE]; // Does this need to be malloced?
	// N_SAMPLE is number of input vectors
	size_t labels_size = N_SAMPLE * sizeof(int);

	auto t_elapsed = std::chrono::high_resolution_clock::now() - t_start;
	long mSec = std::chrono::duration_cast<std::chrono::milliseconds>(t_elapsed).count();
	long mSec1 = mSec;
	std::cout << "Reading data took " << mSec << " mSec" << std::endl;

	t_start = std::chrono::high_resolution_clock::now();

	// Host allocated memory 
	__hypervector__<Dhv, int> encoded_hv = __hetero_hdc_hypervector<Dhv, int>();
	int* encoded_hv_buffer = new int[Dhv];
	*((__hypervector__<Dhv, int>*) encoded_hv_buffer) = encoded_hv;
	size_t encoded_hv_size = Dhv * sizeof(int);
	
	// Used to store a temporary cluster for initializion
	__hypervector__<Dhv, int> cluster = __hetero_hdc_hypervector<Dhv, int>();
	int* cluster_buffer = new int[Dhv];
	//*(__hypervector__<Dhv, int>* cluster_buffer) = cluster;
	//__hypervector__<Dhv, int>* cluster_ptr = &cluster;
	size_t cluster_size = Dhv * sizeof(int);

	// Read from during clustering, updated from clusters_temp.
	__hypermatrix__<N_CENTER, Dhv, int> clusters = __hetero_hdc_hypermatrix<N_CENTER, Dhv, int>();
	int* clusters_buffer = new int[N_CENTER * Dhv];
	//*((__hypermatrix__<N_CENTER, Dhv, int>*) clusters_buffer) = clusters;
	//__hypermatrix__<N_CENTER, Dhv, int>* clusters__ptr = &clusters;
	size_t clusters_size = N_CENTER * Dhv * sizeof(int);

	// Gets written into during clustering, then is used to update 'clusters' at the end.
	__hypermatrix__<N_CENTER, Dhv, int> clusters_temp = __hetero_hdc_hypermatrix<N_CENTER, Dhv, int>();
	int* clusters_temp_buffer = new int[N_CENTER * Dhv];
	//*((__hypermatrix__<N_CENTER, Dhv, int>*) clusters_temp_buffer) = clusters_temp;
	//__hypermatrix__<N_CENTER, Dhv, int>* clusters_temp_ptr = &clusters_temp;

	// Temporarily store scores, allows us to split score calcuation into a separte task.
	__hypervector__<Dhv, int> scores = __hetero_hdc_hypervector<Dhv, int>();
	int* scores_buffer = new int[N_CENTER];
	size_t scores_size = N_CENTER * sizeof(int);

	// Encoding matrix: First we write into rp_matrix_transpose, then transpose it to get rp_matrix,
	// which is the correct dimensions for encoding input features.
	__hypermatrix__<N_FEAT, Dhv, int> rp_matrix_transpose = __hetero_hdc_hypermatrix<N_FEAT, Dhv, int>();
	__hypermatrix__<Dhv, N_FEAT, int> rp_matrix = __hetero_hdc_hypermatrix<Dhv, N_FEAT, int>();
	int* rp_matrix_buffer = new int[N_FEAT * Dhv];

	//__hypermatrix__<Dhv, N_FEAT, int>* rp_matrix_ptr = &rp_matrix;
	size_t rp_matrix_size = N_FEAT * Dhv * sizeof(int);

	__hypervector__<Dhv, int> rp_seed = __hetero_hdc_create_hypervector<Dhv, int>(0, (void*) initialize_rp_seed);	

	std::cout << "Dimension over 32: " << Dhv/32 << std::endl;
	//We need a seed ID. To generate in a random yet determenistic (for later debug purposes) fashion, we use bits of log2 as some random stuff.

	std::cout << "Seed hv:\n";
	print_hv<Dhv, int>(rp_seed);
	std::cout << "After seed generation\n";

	// Dhv needs to be greater than N_FEAT for the orthognality to hold.

	// Generate the random projection matrix. Dhv rows, N_FEAT cols, so Dhv x N_FEAT.
	__hypervector__<Dhv, int> row = __hetero_hdc_hypervector<Dhv, int>();

	// Each row is just a wrap shift of the seed.
	for (int i = 0; i < N_FEAT; i++) {
		row = __hetero_hdc_wrap_shift<Dhv, int>(rp_seed, i);
		//print_hv<Dhv, int>(row);
		__hetero_hdc_set_matrix_row<N_FEAT, Dhv, int>(rp_matrix_transpose, row, i);
	} 

	// Now transpose in order to be able to multiply with input hv in DFG.
	rp_matrix = __hetero_hdc_matrix_transpose<N_FEAT, Dhv, int>(rp_matrix_transpose, N_FEAT, Dhv);

	// Make sure transpose worked:
	std::cout << "Transpose of encoding matrix:" << std::endl;
	//__hypervector__<N_FEAT, int> tmp = __hetero_hdc_hypervector<N_FEAT, int>();
	//for (int i = 0 ; i < Dhv; i++) {
	//	tmp = __hetero_hdc_get_matrix_row<Dhv, N_FEAT, int>(rp_matrix, Dhv, N_FEAT, i);
		//print_hv<N_FEAT, int>(tmp);
	//}
	// Print out at the end here.
	//print_hv<N_FEAT, int>(row);

	*((__hypermatrix__<Dhv, N_FEAT, int>*) rp_matrix_buffer) = rp_matrix;
	// Initialize cluster hvs.
	for (int k = 0; k < N_CENTER; k++) {
		__hypervector__<N_FEAT, int> datapoint_hv = __hetero_hdc_create_hypervector<N_FEAT, int>(1, (void*) initialize_hv, &input_vectors[k * N_FEAT]);
		int* datapoint_hv_buffer = new int[N_FEAT];
		*((__hypervector__<N_FEAT, int> *) datapoint_hv_buffer) = datapoint_hv;
		// Encode the first N_CENTER hypervectors and set them to be the clusters.

        printf("Launching RP Encoding Copy DAG!\n");
		void* initialize_DFG = __hetero_launch(
			(void*) rp_encoding_node_copy<Dhv, N_FEAT>,
			2 + 1,
			/* Input Buffers: 2*/ 
			rp_matrix_buffer, rp_matrix_size, //false,
			datapoint_hv_buffer, input_vector_size,
			/* Output Buffers: 1*/ 
			cluster_buffer, cluster_size,  //false,
			1,
			cluster_buffer, cluster_size //false
		);

		__hetero_wait(initialize_DFG);

        printf("Completed RP Encoding Copy DAG!\n");


		// rp_encoding_node encodes a single cluster, which we then have to assign to our big group of clusters in cluster[s].
		// Note cluster vs clusters
		//__hetero_hdc_set_matrix_row<N_CENTER, Dhv, int>(*clusters_ptr, *cluster_ptr, k);
		// Do these need to be casted?
		__hetero_hdc_set_matrix_row<N_CENTER, Dhv, int>(*((__hypermatrix__<N_CENTER, Dhv, int>*) clusters_buffer), *((__hypervector__<Dhv, int>*) cluster_buffer), k);
		// Print the encoded clusters
		// Cluster temp is used for printing
		__hypervector__<Dhv, int> cluster_temp = __hetero_hdc_get_matrix_row<N_CENTER, Dhv, int>(*((__hypermatrix__<N_CENTER, Dhv, int>*) clusters_buffer), N_CENTER, Dhv, k);
		std::cout << k << " ";
		print_hv<Dhv, int>(cluster_temp);
	}


	// Moved allocation outside of loop
	int* datapoint_hv_buffer = new int[N_FEAT];

	for (int i = 0; i < EPOCH; i++) {
		// Can we normalize the hypervectors here or do we have to do that in the DFG.
        printf("Epoch: %d\n", i);
		for (int j = 0; j < N_SAMPLE; j++) {
            //printf("Epoch: %d, N_SAMPLE: %d\n", i, j);

			// We can move this allocation outside of the loop? as in allocation for scores.
			__hypervector__<N_FEAT, int> datapoint_hv = __hetero_hdc_create_hypervector<N_FEAT, int>(1, (void*) initialize_hv, &input_vectors[j * N_FEAT]);
			*((__hypervector__<N_FEAT, int>*) datapoint_hv_buffer) = datapoint_hv;

            std::cout << "Launching main DAG!: " <<i << " "<< j <<std::endl;

			// Root node is: Encoding -> Clustering for a single HV.
			void *DFG = __hetero_launch(
				(void*) root_node<Dhv, N_CENTER, N_SAMPLE, N_FEAT>,
				/* Input Buffers: 2*/ 8 + 1,
				rp_matrix_buffer, rp_matrix_size, //false,
				datapoint_hv_buffer, input_vector_size, //true,
				/* Local Var Buffers 4*/
				encoded_hv_buffer, encoded_hv_size,// false,
				clusters_buffer, clusters_size, //false,
				clusters_temp_buffer, clusters_size, //false,
				scores_buffer, scores_size,
				j, 0, 
				/* Output Buffers: 1*/ 
				labels, labels_size,
				1,
				labels, labels_size //, false
			);


			__hetero_wait(DFG);

            std::cout << "Completed main DAG!" << std::endl;
		}
		// then update clusters and copy clusters_tmp to clusters, 
		// Calcualte eucl maginutde of each cluster HV before copying it over?.

		// TODO: Move to DAG
		for (int k = 0; k < N_CENTER; k++) {
            printf("Outer Loop DAG, k: %d\n",k);
			// set temp_clusters -> clusters
			__hypervector__<Dhv, int> cluster = __hetero_hdc_get_matrix_row<N_CENTER, Dhv, int>(clusters_temp, N_CENTER, Dhv, k);
			// Normalize or sign?
			__hypervector__<Dhv, int> cluster_norm = __hetero_hdc_sign<Dhv, int>(cluster);
			__hetero_hdc_set_matrix_row(clusters, cluster_norm, k);
		} 
	}


	t_elapsed = std::chrono::high_resolution_clock::now() - t_start;
	
	mSec = std::chrono::duration_cast<std::chrono::milliseconds>(t_elapsed).count();
	
	/*
	long double distance = 0;
	int count = 0;

	for(int i = 0; i < N_SAMPLE; i++){
		//cout << labels_gmem[i] << endl;
		long double sum1 = 0;
		if(labels_gmem[i] < N_CENTER){
			count++;
			for(int j = 0; j < N_FEAT; j++){
				long double temp;
				if(shuffled)
					temp = X_data_shuffled[labels_gmem[i]*N_FEAT + j] - X_data_shuffled[i*N_FEAT + j];
				else
					temp = X_data[labels_gmem[i]*N_FEAT + j] - X_data[i*N_FEAT + j];
				sum1 += temp*temp;
			}
		}
		distance += sqrt(sum1);
	}
	*/

	std::cout << "\nReading data took " << mSec1 << " mSec" << std::endl;    
	std::cout << "Execution (" << EPOCH << " epochs)  took " << mSec << " mSec" << std::endl;
	
	std::ofstream myfile("out.txt");
	for(int i = 0; i < N_SAMPLE; i++){
		myfile << y_data[i] << " " << labels[i] << std::endl;
	}
	//calculate score
	//string command = "python -W ignore mutual_info.py";
	//system(command.c_str());
 	//cout << "\nNormalized distance:\t" << int(distance / count / Dhv) << endl;
    //cout << "\nAccuracy = " << float(correct)/N_SAMPLE << endl;
	__hpvm__cleanup();
	return 0;
}




