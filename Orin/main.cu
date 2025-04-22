#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <fstream>
#include <random>
#include <chrono>
#include "include/preprocessor.hpp"
#include "include/csv.hpp"
#include "include/cudadebug.cuh"
#include "include/encoding.cuh"
#include "include/kernels.cuh"

#include <thrust/device_vector.h>
#include <thrust/transform_reduce.h>

#include <cublas_v2.h>
// #include <cuda_runtime.h>

#define USE_COS_SIMILARITY
#define N_THREADS 1024

#define N_CLASS 26
#define N_FEAT 617
#define N_FEAT_PAD 624
#define Dhv 2048
#define N_SAMPLE 6238
#define N_TEST 1559
#define EPOCH 5

void l2norm(std::vector<std::vector<float>>& X) {
    float sq_sum_of_elems = 0;
    for(auto& xrow : X) {
        sq_sum_of_elems = 0;
        for(auto& n : xrow) {
            sq_sum_of_elems += n * n;
        }
        sq_sum_of_elems = sqrt(sq_sum_of_elems);
        for(auto& n : xrow) {
            n /= sq_sum_of_elems;
        }
    }       
}

struct square { __host__ __device__ float operator()(float x) { return x * x; } };


__device__ float* get2df(float* p, const int x, int y, const int stride) {
        return (float*)((char*)p + x*stride) + y;
}

__global__ void updateClassHV(float* hv_matrix, float* weights, int* y_pred, int N, int D)
{
    const int d = threadIdx.x + blockIdx.x * blockDim.x;
	if (d >= D)
        return;
    
    const int MAX_CLASS = 50;  // Maximum supported Classes

    float sum_temp[MAX_CLASS] = {0, };
    // int class_cnt[MAX_CLASS] = {0, };

    for(int ii = 0; ii < N; ++ii) {
        int idx = y_pred[ii];
        sum_temp[idx] += hv_matrix[ii * D + d];  // 0~K-1
        // class_cnt[idx]++;
    }
    for(int ii = 0; ii < N; ++ii) {
        int idx = y_pred[ii];
        
        if (sum_temp[idx] == 0)
            weights[idx * D + d] = hv_matrix[20 * D + d];  //Randomize
        else
            weights[idx * D + d] = sum_temp[idx];
    }
}

__global__ void normMatRow(float* result, float* inputMat, int setNum, int colNum) {
    for (int rowNum = blockIdx.x * blockDim.x + threadIdx.x; 
        rowNum < setNum; 
        rowNum += blockDim.x * gridDim.x)
    {
        // result[rowNum] = normf(colNum, inputMat + rowNum * colNum);
        result[rowNum] = sqrt(thrust::transform_reduce(thrust::device, inputMat + rowNum * colNum, inputMat + (rowNum + 1) * colNum, square(), 0.0f, thrust::plus<float>()));
    }
}

__global__ void cosineSimilarityVec(float* result, float* norm_1, int colNum, float* norm_2_const, int dataidx) {
    float norm_2 = norm_2_const[dataidx];
    int idx = threadIdx.x + blockDim.x * blockIdx.x;
    if (idx < colNum)
        result[idx] = result[idx] / (norm_1[idx] * norm_2);
}

__global__
void guessVecGenCompareCosine(int* y_pred, float* weights_norm, float* data_norm,
    const float * guess_table, const int setNum, const int n_class) {

    int rowNum = threadIdx.x + blockDim.x * blockIdx.x;
    float norm_2 = data_norm[rowNum];

    if (rowNum < setNum) {
        float max_value = guess_table[n_class * rowNum + 0] / (weights_norm[0] * norm_2);
        // float max_value = guess_table[n_class * rowNum + 0]; 
        int max_idx = 0;
        for (int j = 1; j < n_class; j++){
            float val_to_compare = guess_table[n_class * rowNum + j] / (weights_norm[j] * norm_2);
            if (max_value < val_to_compare) {
                max_value = val_to_compare;
                max_idx = j;
            }
        }
        y_pred[rowNum] = max_idx;
    }
}

__global__
void guessVecGenCompareDot(int* y_pred,
    const float * guess_table, const int setNum, const int n_class) {

    int rowNum = threadIdx.x + blockDim.x * blockIdx.x;
    if (rowNum < setNum) {
        float max_value = guess_table[n_class * rowNum + 0];
        // float max_value = guess_table[n_class * rowNum + 0];
        int max_idx = 0;
        for (int j = 1; j < n_class; j++){
            float val_to_compare = guess_table[n_class * rowNum + j];
            if (max_value < val_to_compare) {
                max_value = val_to_compare;
                max_idx = j;
            }
        }
        y_pred[rowNum] = max_idx;
    }
}




int main(int argc, char* argv[]) {
    
    auto t_start =  std::chrono::high_resolution_clock::now();

    // ./main [TRAIN dataset path] [DIM] [ITER] [Q]
    // Example:
    // ./main datasets/UCIHAR/UCIHAR_train.choir_dat 10000 20 100
    int nFeatures_train, nClasses_train;  // nFeatures is same as x_train[0].size()
    nFeatures_train = N_FEAT;
    nClasses_train = N_CLASS; 
    // std::vector<std::vector<float>> x_train;

    // l2norm(x_train);
    // std::vector<float> x_train_flat = flatten(x_train);


    // base_creation: linear
    int dim = Dhv;
    int iter_num = EPOCH;
    int K = N_CLASS;
    int train_set_num = N_SAMPLE;

    float* x_train_flat = new float[train_set_num * nFeatures_train];
    size_t x_train_flat_size  = train_set_num * nFeatures_train * sizeof(float);
    int* y_train = new int[nClasses_train];
    size_t y_train_size = nClasses_train * sizeof(int);


    int base_size = nFeatures_train * dim;
    int train_encode_size = train_set_num * dim;

    std::cout << train_set_num << " " << nFeatures_train << std::endl;

    // K equals to the number of classes

    // generate bases
    std::vector<float> bases;  // flattened
    std::vector<float> base_v1(dim/2, 1);
    std::vector<float> base_v2(dim/2, -1);
    base_v1.insert(base_v1.end(), base_v2.begin(), base_v2.end());
    // obtain a time-based seed
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
        for(int i = 0 ; i < nFeatures_train; i++) {
        std::shuffle(base_v1.begin(), base_v1.end(), std::default_random_engine(seed));
        bases.insert(bases.end(), base_v1.begin(), base_v1.end());
    }


    // rand gen K number of 0 ~ train_set_num - 1
    std::vector<int> rand_weights(train_set_num);
    std::iota(std::begin(rand_weights), std::end(rand_weights), 0);                                                                                        
    std::shuffle(rand_weights.begin(), rand_weights.end(), std::default_random_engine(seed));  // random order
    rand_weights.resize(K);

    int* cluster_results;
    cluster_results = (int*)malloc(train_set_num * sizeof(int));

    //////////////////////////////////////////////////////////////////////////
    // GPU LOAD
    float* d_bases = NULL;
    float* d_x_train = NULL;
    float* d_hvs_train = NULL;

#ifdef USE_COS_SIMILARITY
    float* d_train_norm = NULL;
    float* d_weights_norm = NULL;
#endif
    HANDLE_ERROR(cudaMalloc((void **)&d_bases, base_size * sizeof(float)));
    HANDLE_ERROR(cudaMalloc((void **)&d_x_train, x_train_flat_size));
    HANDLE_ERROR(cudaMalloc((void **)&d_hvs_train, 4 * train_encode_size * sizeof(float)));
    
#ifdef USE_COS_SIMILARITY
    HANDLE_ERROR(cudaMalloc((void **)&d_train_norm, train_set_num * sizeof(float)));
    HANDLE_ERROR(cudaMalloc((void **)&d_weights_norm, K * sizeof(float)));
#endif

    HANDLE_ERROR(cudaMemcpy(d_bases, bases.data(), base_size * sizeof(float), cudaMemcpyHostToDevice));
    HANDLE_ERROR(cudaMemcpy(d_x_train, x_train_flat, x_train_flat_size, cudaMemcpyHostToDevice));

    float* d_weights = NULL;
    HANDLE_ERROR(cudaMalloc((void **)&d_weights, K * dim * sizeof(float)));

    float* d_guess_table = NULL;
    int* d_y_pred = NULL;
    HANDLE_ERROR(cudaMalloc((void **)&d_guess_table, K * train_set_num * sizeof(float)));
    HANDLE_ERROR(cudaMalloc((void **)&d_y_pred, train_set_num * sizeof(int)));

    cudaEvent_t start, stop1, stop2;
    cudaError_t err = cudaSuccess;

    cudaEventCreate(&start);
    cudaEventCreate(&stop1);
    cudaEventCreate(&stop2);

    cublasHandle_t handle;
    cublasCreate(&handle);
    const float alpha = 1;
    const float beta = 0;

    cudaEventRecord(start);
    printf("Starting Encoding Stage...\n");

    std::cout << "matmul params: " << dim << " " <<  train_set_num << " " << nFeatures_train << std::endl;
    std::cout << base_size * sizeof(float) << " " << x_train_flat_size << " " << 4 * train_encode_size * sizeof(float) << std::endl;
    // Encode stage: Linear
    cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, 
               dim, train_set_num, nFeatures_train, 
               &alpha, d_bases, dim, 
               d_x_train, nFeatures_train, &beta, 
               d_hvs_train, dim);
    cudaThreadSynchronize();

    err = cudaGetLastError();
    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to launch kernel (error code %s)!\n",
                cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Initialize class HVs
    for (int ii = 0; ii < K; ++ii) {
        HANDLE_ERROR(cudaMemcpy(d_weights + ii * dim, d_hvs_train + rand_weights[ii] * dim, dim * sizeof(float), cudaMemcpyDeviceToDevice));
    }

    cudaEventRecord(stop1);
    cudaEventSynchronize(stop1);

    // Clustering stage
    // make_guess and create guess table
    printf("Clustering stage...\n");

#ifdef USE_COS_SIMILARITY
    normMatRow<<<(train_set_num + N_THREADS - 1) / N_THREADS, N_THREADS>>>(d_train_norm, d_hvs_train, train_set_num, dim);
#endif

    for (int iter = 0; iter < iter_num; ++iter) {  // Retraining, Different from max_iter
        cublasSgemm(handle, CUBLAS_OP_T, CUBLAS_OP_N, 
                    K, train_set_num, dim, 
                    &alpha, d_weights, dim, 
                    d_hvs_train, dim, &beta, 
                    d_guess_table, K);   // np.dot
        cudaThreadSynchronize();

#ifdef USE_COS_SIMILARITY
        normMatRow<<<(K + N_THREADS - 1) / N_THREADS, N_THREADS>>>(d_weights_norm, d_weights, K, dim);

        guessVecGenCompareCosine<<<(train_set_num + N_THREADS - 1)/N_THREADS, N_THREADS>>>(d_y_pred, d_weights_norm, d_train_norm, d_guess_table, train_set_num, K);
#endif

#ifdef USE_DOT_SIMILARITY
        guessVecGenCompareDot<<<(train_set_num + N_THREADS - 1)/N_THREADS, N_THREADS>>>(d_y_pred, d_guess_table, train_set_num, K);
#endif

        updateClassHV<<<(dim + N_THREADS - 1) / N_THREADS, N_THREADS>>>(d_hvs_train, d_weights, d_y_pred, train_set_num, dim);
    }

    HANDLE_ERROR(cudaMemcpy(cluster_results, d_y_pred, train_set_num * sizeof(int), cudaMemcpyDeviceToHost));
    cudaEventRecord(stop2);
    cudaEventSynchronize(stop2);

    cublasDestroy(handle);
    HANDLE_ERROR(cudaFree(d_bases));
    HANDLE_ERROR(cudaFree(d_x_train));
    HANDLE_ERROR(cudaFree(d_hvs_train));
    HANDLE_ERROR(cudaFree(d_weights));

    HANDLE_ERROR(cudaFree(d_guess_table));
    HANDLE_ERROR(cudaFree(d_y_pred));

#ifdef USE_COS_SIMILARITY
    HANDLE_ERROR(cudaFree(d_train_norm));
    HANDLE_ERROR(cudaFree(d_weights_norm));
#endif


    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop1);
    printf("GPU Execution time (Encoding): %f\n", milliseconds);
    cudaEventElapsedTime(&milliseconds, stop1, stop2);
    printf("GPU Execution time (Clustering): %f\n", milliseconds);

    auto t_elapsed = std::chrono::high_resolution_clock::now() - t_start;
    long ms = std::chrono::duration_cast<std::chrono::milliseconds>(t_elapsed).count();
    std::cout << ms << std::endl;
    // write file
    // std::ofstream out("cluster_results.csv");
    // for (int idx = 0; idx < train_set_num; ++idx) {
    //     out << cluster_results[idx] <<',';
    // }
    // out << '\n';
    
    // std::ofstream out_gnd("train_labels.csv");
    // // for (auto& data : y_train) {
    // //     out_gnd << data <<',';
    // // }
    // out_gnd << '\n';
    
    cudaEventDestroy(start);
    cudaEventDestroy(stop1);
    cudaEventDestroy(stop2);

    free(cluster_results);

    return 0;
}
