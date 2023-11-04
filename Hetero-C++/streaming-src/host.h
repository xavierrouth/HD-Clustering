#include <cmath>
#include <fstream>
#include <sstream>
#include <string>
#include <algorithm>
#include <iterator>
#include <time.h>
#include <chrono>
#include <vector>
#include <unistd.h>
#include <iostream>
#include <fstream>

#define Dhv				2048  //hypervectors length
#define UCIHAR

#ifdef MNIST

#define N_CENTER		10	//number of centers. (e.g., isolet: 26,)
#define N_FEAT			784	//feature per input (e.g., isolet: 617)
#define N_SAMPLE 		10000
std::string X_data_path = "../dataset/mnist_testX.bin";
std::string y_data_path = "../dataset/mnist_testY.bin";
#endif

#ifdef ISOLET

#define N_CENTER		26	//number of centers. (e.g., isolet: 26,)
#define N_FEAT			617	//feature per input (e.g., isolet: 617)

#define N_SAMPLE 		6238
std::string X_data_path = "../dataset/isolet_train_trainX.bin";
std::string y_data_path = "../dataset/isolet_train_trainY.bin";
#endif

#ifdef UCIHAR

#define N_CENTER		6	//number of centers. (e.g., isolet: 26,)
#define N_FEAT			561	//feature per input (e.g., isolet: 617)
#define N_SAMPLE 		6213
std::string X_data_path = "../dataset/ucihar_trainX.bin";
std::string y_data_path = "../dataset/ucihar_trainY.bin";
#endif


#define COL				8 //number of columns of a matrix-vector multiplication window
#define ROW				32 //number of rows of a matrix-vector multiplication window (32, 64, 128, 256, 512)

#define PAD_			(N_FEAT & (COL - 1))
#if PAD_ == 0
	#define PAD 		0
#else
	#define PAD 		(COL - PAD_)
#endif

#define N_FEAT_PAD		(N_FEAT + PAD)	//feature per input (e.g., isolet: 624, ucihar 568)

//int EPOCH = 10;
bool shuffled = false;


