#include <iostream>
#include <assert.h>
#include <cstdlib>

#define N_FEAT			617	//feature per input (e.g., isolet: 617)
#define N_CENTER		26	//number of classes. (e.g., isolet: 26)
#define Dhv				2048 //hypervectors length
#define COL				8 //number of columns of a matrix-vector multiplication window
#define ROW				32 //number of rows of a matrix-vector multiplication window (32, 64, 128, 256, 512)

#define PAD_			(N_FEAT & (COL - 1))
#if PAD_ == 0
	#define PAD 		0
#else
	#define PAD 		(COL - PAD_)
#endif

#define N_FEAT_PAD		(N_FEAT + PAD)	//feature per input (e.g., isolet: 624, ucihar 568)

void hd(int *__restrict input_gmem, std::size_t input_gmem_size, int *__restrict ID_gmem, std::size_t ID_gmem_size, int *__restrict labels_gmem, std::size_t labels_gmem_size, int EPOCH, int size);
