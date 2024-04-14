#include <heterocc.h>
#include <hpvm_hdc.h>
#include "DFG.hpp"
#include "host.h"
#include <vector>
#include <cassert>
#include <cmath>

#define HAMMING_DIST
#ifdef HAMMING_DIST
#define SCORES_TYPE hvtype
#else
#define SCORES_TYPE float
#endif

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

	return ele ? (T) 1 : (T) -1;
}

template <typename T>
T copy(T* vec, size_t loop_index_var) {
	return vec[loop_index_var];
}


extern "C" void run_hd_clustering(int EPOCH, hvtype* rp_matrix_buffer, hvtype* input_vectors, int* labels);

int main(int argc, char** argv) {
#ifndef NODFG
	__hpvm__init();
#endif

	auto t_start = std::chrono::high_resolution_clock::now();
	std::cout << "Main Starting" << std::endl;

	assert(argc == 2 && "Expected parameter");
	int EPOCH = std::atoi(argv[1]);
   
	std::vector<int> X_data;
	std::vector<int> y_data;
	datasetBinaryRead(X_data, X_data_path);
	datasetBinaryRead(y_data, y_data_path);

	std::cout << "Read Data Starting" << std::endl;
	int shuffle_arr[y_data.size()];
	
	assert(N_SAMPLE == y_data.size());
	std::vector<hvtype> floatVec(X_data.begin(), X_data.end());
	hvtype* input_vectors = floatVec.data();
	__hypermatrix__<N_SAMPLE,N_FEAT, hvtype> input_vectors_matrix = __hetero_hdc_create_hypermatrix<N_SAMPLE, N_FEAT, hvtype>(1, (void*) copy<hvtype>, input_vectors);	
    auto input_vectors_handle = __hetero_hdc_get_handle<N_SAMPLE, N_FEAT>(input_vectors_matrix);



	int *labels = new int[N_SAMPLE]; // Does this need to be malloced?
	for (int i = 0; i < N_SAMPLE; ++i) {
		labels[i] = 0;
	}

	auto t_elapsed = std::chrono::high_resolution_clock::now() - t_start;
	long mSec = std::chrono::duration_cast<std::chrono::milliseconds>(t_elapsed).count();
	long mSec1 = mSec;
	std::cout << "Reading data took " << mSec << " mSec" << std::endl;

	t_start = std::chrono::high_resolution_clock::now();

	__hypervector__<Dhv, hvtype> rp_seed = __hetero_hdc_create_hypervector<Dhv, hvtype>(0, (void*) initialize_rp_seed<hvtype>);	
    auto rp_seed_buffer = __hetero_hdc_get_handle<Dhv, hvtype>(rp_seed);


	std::cout << "Dimension over 32: " << Dhv/32 << std::endl;
	//We need a seed ID. To generate in a random yet determenistic (for later debug purposes) fashion, we use bits of log2 as some random stuff.

	std::cout << "Seed hv:\n";
	std::cout << "After seed generation\n";

	// Dhv needs to be greater than N_FEAT for the orthognality to hold.

    __hypermatrix__<N_FEAT, Dhv, hvtype> rp_matrix = __hetero_hdc_hypermatrix<N_FEAT,Dhv, hvtype>();
    __hypermatrix__<N_FEAT, Dhv, hvtype> shifted = __hetero_hdc_hypermatrix<N_FEAT,Dhv, hvtype>();
    __hypervector__<Dhv, hvtype> row = __hetero_hdc_hypervector<Dhv, hvtype>();

    auto rp_matrix_buffer = __hetero_hdc_get_handle<N_FEAT, Dhv, hvtype>(rp_matrix);
    auto shifted_buffer = __hetero_hdc_get_handle<N_FEAT, Dhv, hvtype>(rp_matrix);
    auto row_buffer = __hetero_hdc_get_handle<Dhv, hvtype>(row);





	auto gen_rp_matrix_t_start = std::chrono::high_resolution_clock::now();
#ifndef NODFG
    void* GenRPMatDAG = __hetero_launch((void*) gen_rp_matrix<Dhv,  N_FEAT>, 4, rp_seed_buffer, sizeof(hvtype) * Dhv, row_buffer, sizeof(hvtype) * Dhv, shifted_buffer, sizeof(hvtype) * (N_FEAT * Dhv), rp_matrix_buffer, sizeof(hvtype) * (N_FEAT * Dhv), 1, rp_matrix_buffer, sizeof(hvtype) * (N_FEAT * Dhv));
    __hetero_wait(GenRPMatDAG);
#else
    gen_rp_matrix<Dhv, N_FEAT>(rp_seed_buffer, sizeof(hvtype) * Dhv, (__hypervector__<Dhv, hvtype> *) row_buffer, sizeof(hvtype) * Dhv, (__hypermatrix__<N_FEAT, Dhv, hvtype> *) shifted_buffer, sizeof(hvtype) * (N_FEAT * Dhv), (__hypermatrix__<Dhv, N_FEAT, hvtype> *) rp_matrix_buffer, sizeof(hvtype) * (N_FEAT * Dhv));
#endif
	auto gen_rp_matrix_t_elapsed = std::chrono::high_resolution_clock::now() - gen_rp_matrix_t_start;
	long gen_rp_matrix_mSec = std::chrono::duration_cast<std::chrono::milliseconds>(gen_rp_matrix_t_elapsed).count();
	std::cout << "gen_rp_matrix: " << gen_rp_matrix_mSec << " mSec" << std::endl;


	run_hd_clustering(EPOCH, (hvtype*) rp_matrix_buffer,(hvtype*) input_vectors_handle, labels);

	t_elapsed = std::chrono::high_resolution_clock::now() - t_start;
	mSec = std::chrono::duration_cast<std::chrono::milliseconds>(t_elapsed).count();
	std::cout << "\nReading data took " << mSec1 << " mSec" << std::endl;    
	std::cout << "Execution (" << EPOCH << " epochs)  took " << mSec << " mSec" << std::endl;
	
	std::ofstream myfile("out.txt");
	for(int i = 0; i < N_SAMPLE; i++){
		myfile << y_data[i] << " " << labels[i] << std::endl;
	}
#ifndef NODFG
	__hpvm__cleanup();
#endif
	return 0;
}

extern "C" void run_hd_clustering(int EPOCH, hvtype* rp_matrix_buffer, hvtype* input_vectors, int* labels) {
	//std::ofstream file_rp_matrix_buffer("rp_matrix_buffer.csv");
	//std::ofstream file_input_vectors("input_vectors.csv");
	//for (int i = 0; i < N_FEAT *  Dhv; ++i) {
	//	file_rp_matrix_buffer << rp_matrix_buffer[i];
	//	if (i + 1 < N_FEAT *  Dhv) {
	//		file_rp_matrix_buffer << ",";
	//	}
	//}
	//for (int i = 0; i < N_SAMPLE * N_FEAT_PAD; ++i) {
	//	file_input_vectors << input_vectors[i];
	//	if (i + 1 < N_SAMPLE * N_FEAT_PAD) {
	//		file_input_vectors << ",";
	//	}
	//}

	size_t input_vector_size = N_FEAT * sizeof(hvtype);
	size_t labels_size = N_SAMPLE * sizeof(int);

    __hypervector__<Dhv, hvtype> encoded_hv = __hetero_hdc_hypervector<Dhv, hvtype>();
	//hvtype encoded_hv_buffer[Dhv];
    auto encoded_hv_buffer = __hetero_hdc_get_handle<Dhv, hvtype>(encoded_hv);
	size_t encoded_hv_size = Dhv * sizeof(hvtype);

    __hypervector__<Dhv, hvtype> update_hv = __hetero_hdc_hypervector<Dhv, hvtype>();
	// hvtype update_hv_ptr[Dhv];
    auto update_hv_ptr = __hetero_hdc_get_handle<Dhv, hvtype>(update_hv);
	size_t update_hv_size = Dhv * sizeof(hvtype);


	__hypermatrix__<N_CENTER, Dhv, hvtype> clusters = __hetero_hdc_hypermatrix<N_CENTER, Dhv, hvtype>();
    auto clusters_handle = __hetero_hdc_get_handle<N_CENTER, Dhv, hvtype>(clusters);

	//static __hypervector__<Dhv, hvtype> encoded_hvs[N_SAMPLE];
	__hypermatrix__<N_SAMPLE, Dhv, hvtype> encoded_hvs = __hetero_hdc_hypermatrix<N_SAMPLE, Dhv, hvtype>();;
    auto encoded_hvs_handle = __hetero_hdc_get_handle<N_SAMPLE, Dhv, hvtype>(encoded_hvs);



	size_t cluster_size = Dhv * sizeof(hvtype);
	size_t clusters_size = N_CENTER * Dhv * sizeof(hvtype);
	__hypermatrix__<N_CENTER, Dhv, hvtype> clusters_temp = __hetero_hdc_hypermatrix<N_CENTER, Dhv, hvtype>();
    //SCORES_TYPE scores_buffer[N_CENTER];
    __hypervector__<N_CENTER, SCORES_TYPE> scores = __hetero_hdc_hypervector<N_CENTER,  SCORES_TYPE>();
    auto scores_buffer = __hetero_hdc_get_handle<N_CENTER,  SCORES_TYPE>(scores);
	size_t scores_size = N_CENTER * sizeof(SCORES_TYPE);
	size_t rp_matrix_size = N_FEAT * Dhv * sizeof(hvtype);

	__hetero_hdc_encoding_loop(0, (void*) InitialEncodingDAG<Dhv, N_FEAT>, N_SAMPLE, N_CENTER, N_FEAT, N_FEAT_PAD, rp_matrix_buffer, rp_matrix_size, input_vectors, input_vector_size, encoded_hvs_handle, cluster_size);
	for (int i = 0; i < N_CENTER; ++i) {
        auto encoded_hv_i = __hetero_hdc_get_matrix_row<N_SAMPLE, Dhv, hvtype>(encoded_hvs, N_SAMPLE, Dhv, i);
		__hetero_hdc_set_matrix_row(clusters, encoded_hv_i, i);
	}

	std::cout << "Starting clustering\n";
	for (int i = 0; i < EPOCH; i++) {
		auto t_start = std::chrono::high_resolution_clock::now();
		__hetero_hdc_inference_loop(12, (void*) root_node<Dhv, N_CENTER, N_SAMPLE, N_FEAT>, N_SAMPLE, N_FEAT, N_FEAT_PAD, rp_matrix_buffer, rp_matrix_size, input_vectors, input_vector_size, clusters_handle, clusters_size, labels, labels_size, encoded_hv_buffer, encoded_hv_size, scores_buffer, scores_size);
		auto t_end = std::chrono::high_resolution_clock::now();
		long mSec = std::chrono::duration_cast<std::chrono::milliseconds>(t_end-t_start).count();
		std::cout << "Inference: " << mSec << " mSec\n";
			
		// then update clusters and copy clusters_tmp to clusters, 
		for (int j = 0; j < N_SAMPLE; j++) {
			__hypervector__<Dhv, hvtype> update_hv =  __hetero_hdc_get_matrix_row<N_CENTER, Dhv, hvtype>(clusters_temp, N_CENTER, Dhv, labels[j]);

            auto encoded_hv_j = __hetero_hdc_get_matrix_row<N_SAMPLE, Dhv, hvtype>(encoded_hvs, N_SAMPLE, Dhv, j);
			update_hv = __hetero_hdc_sum<Dhv, hvtype>(update_hv, encoded_hv_j); // May need an instrinsic for this.
			__hetero_hdc_set_matrix_row<N_CENTER, Dhv, hvtype>(clusters_temp, update_hv, labels[j]); // How do we normalize?
		} 
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
	}
}
