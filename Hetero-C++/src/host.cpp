#define HPVM 1

#ifdef HPVM
#include <heterocc.h>
#include <hpvm_hdc.h>
#include "DFG.hpp"
#endif
#include "host.h"
#include <vector>
#include <cassert>

#define DUMP(vec, suffix) {\
  FILE *f = fopen("dump/" #vec suffix, "w");\
  if (f) fwrite(vec.data(), sizeof(vec[0]), vec.size(), f);\
  if (f) fclose(f);\
}

template <int N, typename elemTy>
void print_hv(__hypervector__<N, elemTy> hv) {
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

int main(int argc, char** argv)
{
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
	 
	int* input_vector = X_data.data();
	size_t input_vector_size = N_FEAT * sizeof(int); 

	int labels[N_SAMPLE]; // Does this need to be malloced?
	size_t labels_size = N_SAMPLE * sizeof(int);

	auto t_elapsed = std::chrono::high_resolution_clock::now() - t_start;
	long mSec = std::chrono::duration_cast<std::chrono::milliseconds>(t_elapsed).count();
	long mSec1 = mSec;
	std::cout << "Reading data took " << mSec << " mSec" << std::endl;

	t_start = std::chrono::high_resolution_clock::now();

	// Not inputs or outputs to computation:
	// Do these need to be malloced?
	__hypervector__<Dhv, int> encoded_hv;
	__hypervector__<Dhv, int>* encoded_hv_ptr = &encoded_hv;
	size_t encoded_hv_size = Dhv * sizeof(int);

	__hypermatrix__<N_CENTER, Dhv, int> clusters;
	__hypermatrix__<N_CENTER, Dhv, int>* clusters_ptr = &clusters;
	size_t clusters_size = N_CENTER * Dhv * sizeof(int);

	__hypermatrix__<N_CENTER, Dhv, int> clusters_temp;
	__hypermatrix__<N_CENTER, Dhv, int>* clusters_temp_ptr = &clusters_temp;

	// Does this need to be malloced?
	__hypermatrix__<N_FEAT, Dhv, int> rp_matrix;
	__hypermatrix__<N_FEAT, Dhv, int>* rp_matrix_ptr = &rp_matrix;
	size_t rp_matrix_size = N_FEAT * Dhv * sizeof(int);

	__hypervector__<Dhv, int> rp_seed;
	std::cout << "Dimension over 32" << Dhv/32 << std::endl;
	//We need a seed ID. To generate in a random yet determenistic (for later debug purposes) fashion, we use bits of log2 as some random stuff.
	for(int i = 0; i < Dhv/32; i++){
		
        //long double temp = log2(i+2.5) * pow(2, 31);
		//long long int temp2 = (long long int)(temp);
		//temp2 = temp2 % 2147483648; //2^31
		int temp = int(rand());
		for (int j = 0; j < 32; j++) {
			int ele = temp & (1 << j); //temp2 && (0x01 << j);
			std::cout << ele << std::endl;
			if (temp & (1 << j)) {
				rp_seed[0][i * 32 + j] = 1;
			}
			else {
				rp_seed[0][i * 32 + j] = -1;
			}
		}
	}
	print_hv<Dhv, int>(rp_seed);
	std::cout << "After seed generation\n";

	// Dhv needs to be greater than N_FEAT for the orthognality to hold.

	// Generate the random projection matrix.
	for (int i = 0; i < N_FEAT; i++) {
		__hypervector__<Dhv, int> temp = __hetero_hdc_wrap_shift<Dhv, int>(rp_seed,i);
		
		__hetero_hdc_set_matrix_row<N_FEAT, Dhv, int>(rp_matrix, temp, i);
		//print_hv<Dhv, int>(temp);
	}


#ifdef HPVM

	// Do streaming.
	
	/***/
	#if 1
	for (int i = 0; i < EPOCH; i++) {
		// Is it valid to call __hetero_wait multiple times?
		// Can we normalize the hypervectors here or do we have to do that in the DFG.
		for (int j = 0; j < N_SAMPLE; j++) {
			// Encoding -> Clustering for a single HV.
			void *DFG = __hetero_launch(
				(void*) root_node<Dhv, N_CENTER, N_SAMPLE, N_FEAT, int>,
				/* Input Buffers: 5*/ 5 + 1,
				rp_matrix_ptr, rp_matrix_size, //false,
				&input_vector[j * N_FEAT], input_vector_size, //true,
				encoded_hv_ptr, encoded_hv_size,// false,
				clusters_ptr, clusters_size, //false,
				clusters_temp_ptr, clusters_size, //false,
				/* Output Buffers: 2*/ 
				labels, labels_size,
				1,
				labels, labels_size //, false
			);
			__hetero_wait(DFG);
		}
		// then update clusters and copy clusters_tmp to clusters, 

		// How do we keep track of the normalization thing?
		// Calcualte eucl maginutde of each cluster HV before copying it over?.
		for (int k = 0; k < N_CENTER; k++) {
			// set temp_clusters -> clusters
			__hypervector__<Dhv, int> cluster = __hetero_hdc_get_matrix_row<N_CENTER, Dhv, int>(clusters_temp, N_CENTER, Dhv, k);
			// Normalize or sign?
			__hypervector__<Dhv, int> cluster_norm = __hetero_hdc_sign<Dhv, int>(cluster);
			__hetero_hdc_set_matrix_row(clusters, cluster_norm, k);
		} 
	} 
	#endif
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
    
 //   cout << "\nNormalized distance:\t" << int(distance / count / Dhv) << endl;
    //cout << "\nAccuracy = " << float(correct)/N_SAMPLE << endl;
}

#endif