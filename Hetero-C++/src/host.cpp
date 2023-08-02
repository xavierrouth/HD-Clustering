#ifdef HPVM
#include <heterocc.h>
#include <hpvm_hdc.hpp>
#include "DFG.hpp"
#endif
#include "host.h"
#include "hd.h"

#define DUMP(vec, suffix) {\
  FILE *f = fopen("dump/" #vec suffix, "w");\
  if (f) fwrite(vec.data(), sizeof(vec[0]), vec.size(), f);\
  if (f) fclose(f);\
}

void datasetBinaryRead(vector<int> &data, string path){
	std::ifstream file_(path, ios::in | ios::binary);
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
	auto t_start = chrono::high_resolution_clock::now();
	std::cout << "Main Starting" << std::endl;
   
	std::vector<int> X_data;
	std::vector<int> y_data;
	datasetBinaryRead(X_data, X_data_path);
	datasetBinaryRead(y_data, y_data_path);

	std::cout << "Read Data Starting" << std::endl;
	int shuffle_arr[y_data.size()];
	//srand (time(NULL));
	
	srand(0);
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
	
	//int N_SAMPLE = y_data.size();
	assert(N_SAMPLE == y_data.size());
	int input_int = X_data.size();
	 
	std::vector<int> input_data = X_data;
	std::vector<int> labels(N_SAMPLE);

	__hypermatrix__<N_FEAT, Dhv, int> rp_matrix;

	__hypervector__<Dhv, int>::v rp_seed;

	//We need a seed ID. To generate in a random yet determenistic (for later debug purposes) fashion, we use bits of log2 as some random stuff.
	srand(time(NULL));
	for(int i = 0; i < Dhv/32; i++){
        long double temp = log2(i+2.5) * pow(2, 31);
		long long int temp2 = (long long int)(temp);
		temp2 = temp2 % 2147483648;
		for (int j = 0; j < 32; j++) {
			int ele = temp2 && (0x01 << j);
			if (ele == 0) {
				rp_seed[i * 32 + j] = -1;
			}
			else {
				rp_seed[i * 32 + j] = 1;
			}
		}
	}

	// Generate the random projection matrix.
	for (int i = 0; i < N_FEAT; i++) {
		__hypervector__<Dhv, int> temp = __hetero_hdc_wrap_shift<Dhv, int>(rp_seed,i);
		__hetero_hdc_set_matrix_row<N_FEAT, Dhv, int>(rp_matrix, temp, i);
	}

	auto t_elapsed = chrono::high_resolution_clock::now() - t_start;
	long mSec = chrono::duration_cast<chrono::milliseconds>(t_elapsed).count();
	long mSec1 = mSec;
	std::cout << "Reading data took " << mSec << " mSec" << std::endl;

	auto buf_input = input_gmem.data();
	auto buf_ID = ID_gmem.data();
	auto buf_labels = labels_gmem.data();
	auto buf_input_size = input_gmem.size() * sizeof(*buf_input);
	auto buf_ID_size = ID_gmem.size() * sizeof(*buf_ID);
	auto buf_labels_size = labels_gmem.size() * sizeof(*buf_labels);

	t_start = chrono::high_resolution_clock::now();

	// Not inputs or outputs to computation:
	// Do these need to be malloced?
	__hypermatrix__<Dhv, binary> encoded_hv;
	size_t encoded_hvs_size = Dhv * sizeof(int);

	__hypermatrix__<N_CENTER, Dhv, binary> clusters;
	size_t clusters_size = N_CENTER * Dhv * sizeof(int);

	__hypermatrix__<N_CENTER, Dhv, binary> clusters_temp;

	
#ifdef HPVM
	for (int i = 0; i < num_iterations; i++) {
		for (int j = 0; j < )
	}
	void *DFG = __hetero_launch(
		(void *)root_node<Dhv, N_CENTER, N_SAMPLE, N_FEAT, int>,
		5,
		buf_ID, buf_ID_size, 
		buf_input, buf_input_size,
		buf_labels, buf_labels_size,
		&encoded_hvs, encoded_hvs_size,
		&clusters, clusters_size,
		1,
		buf_labels, buf_labels_size
	);
	__hetero_wait(DFG);
#else
	hd(buf_input, buf_input_size,
	   buf_ID, buf_ID_size,
	   buf_labels, buf_labels_size,
	   EPOCH,
	   N_SAMPLE);
#endif
	t_elapsed = chrono::high_resolution_clock::now() - t_start;
	
	mSec = chrono::duration_cast<chrono::milliseconds>(t_elapsed).count();
	
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
	cout << "\nReading data took " << mSec1 << " mSec" << endl;    
	cout << "Execution (" << EPOCH << " epochs)  took " << mSec << " mSec" << endl;
	
	ofstream myfile("out.txt");
	for(int i = 0; i < N_SAMPLE; i++){
		myfile << y_data[i] << " " << labels_gmem[i] << endl;
	}
	//calculate score
	//string command = "python -W ignore mutual_info.py";
	//system(command.c_str());
    
 //   cout << "\nNormalized distance:\t" << int(distance / count / Dhv) << endl;
    //cout << "\nAccuracy = " << float(correct)/N_SAMPLE << endl;
}

