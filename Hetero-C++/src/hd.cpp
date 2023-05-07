#ifdef HPVM
#include <heterocc.h>
#endif
#include "hd.h"

/*
 * inputStream fetches input features as ints, and streames to the next functions.
 *
 * input_gmem (input): input data port; each feature is quantized to an integer.
 * feature_stream (output): N_FEAT_PAD parallel streams to stream the data to the next module.
 * size (input): number of data sampels.
 */
void inputStream(int *__restrict input_gmem, int *__restrict feature_stream, int EPOCH, int size, int iter_epoch, int iter_read) {
	 //Need to move the pointer by intPerInput after each input
	int offset = iter_read * N_FEAT;
	for (int i = 0; i < N_FEAT; i++) {
		feature_stream[i] = input_gmem[offset + i];
	}
	for (int i = 0; i < PAD; i++) {
		feature_stream[N_FEAT + i] = 0;
	}
}

/*
 * encodeUnit reads input features from the stream and obtains encoding hypervector using random projection (RP) algorithm.
 * RP is all about a matrix-vector multplicatoin. The matrix is ID hypervectors arrangaed as Dhv*Div (Dhv = HV dimensions, Div = #input vector elements).
 * We break this A=(Dhv*Div) * B=(Div*1) multiplicaton into slinding windows of ROW*COL on the matrix A.
 * It takes Div/COL cycles for the sliding window to reach the right-most column, when we accomplish ROW dimensions. Total cycles = (Dhv*Div)/(ROW*COL)*(latency of accumulating COL partials).
 * Note that we only have a single seed ID (Dhv bits) in a (Dhv/ROW) x ROW array for column 0, and generate the ID of column k by k-bit rotating (circular shift).
 *
 * feature_stream (input): N_FEAT_PAD parallel streams from the previous module to read input features of a data sample.
 * ID (input): seed ID hypervector, packed as Dhv/ROW (rows) of ROW bit (total Dhv bits).
 * enc_stream (output): streams ROW encoded dimensions per (Div/COL) cycles to the next module.
 * size (input): number of data samples.
 */
void encodeUnit(int *__restrict feature_stream, uint32_t *__restrict ID, int *__restrict enc_stream, int EPOCH, int size, int iter_epoch, int iter_read) {

	//Operate on ROW encoding dimension per cycle.
	int encHV_partial[ROW];

	//ID register to keep ROW+COL bits for a ROW*COL window.
	//ID memory has ROW bits per cell, so we use 2*ROW bit register (extra bits will be used in the next window).
	//It might look a little tricky. See the report for visualization.
	uint64_t ID_reg;

	//Probe ROW rows simultanously for mat-vec multplication (result = r encoding dimension).
	//Each row block has Dhv/ROW rows.
	for (int r = 0; r < Dhv/ROW; r++) {
		//Clear the partial encoding buffer when the window starts the new rows.
		for (int i = 0; i < ROW; i++) {
			encHV_partial[i] = 0;
		}
		//We need to figure out which ID bits should be read.
		//At the beginning of row block r, we read bits of the block r and r+1 (each block has Dhv/ROW bits).
		int cycle = 0;
		int addr1 = r;
		int addr2 = r+1;
		//In the last block, r+1 becomes Dhv/ROW, so we start from 0 (ID bits are stored circular).
		if (addr2 == Dhv/ROW)
			addr2 = 0;
		ID_reg = (((uint64_t) ID[addr2]) << 32) | ((uint64_t) ID[addr1]);

		//Divide each of row blocks into columns (tiles) of COL, i.e., multiply a ROW*COL tile to COL features at a given cycle.
		for (int c = 0; c < N_FEAT_PAD/COL; c++) {

			//Iterate over the rows and columns of the ROW*COL tile to perform matrix-vector multplication.
			for (int i = 0; i < ROW; i++) {
				//In each ID register of 2*ROW bits, bits [0-COL) are for the first row, [1, COL+1) for the second, and so on.
				uint8_t ID_row = (ID_reg >> i) & 0xFF;
				for (int j = 0; j < COL; j++) {
					//For column group c, we read features c*COL to (c+1)*COL.
					int feature = feature_stream[c*COL + j];
					if (ID_row & (1 << j))
						encHV_partial[i] += feature;
					else
						encHV_partial[i] -= feature;
				}
			}
			//After the first window, we move the window to right.
			//The initial 2*ROW ID block has enough bits for ROW/COL consecutive windows (as each window needs ROW+COL bits, not 2*ROW bits).
			//Otherwise, we update the ID address to get the new required ID bits.
			cycle += 1;
			if (cycle == ROW/COL) {
				cycle = 0;
				addr1 = addr1 + 1;
				addr2 = addr2 + 1;
				if (addr1 == Dhv/ROW)
					addr1 = 0;
				if (addr2 == Dhv/ROW)
					addr2 = 0;
				ID_reg = (((uint64_t) ID[addr2]) << 32) | ((uint64_t) ID[addr1]);
			}
			//We have not reached the bound of ROW/COL, so the ID register contains the needed bits.
			//Just shift right by COL, so 'ID_reg.range(i+COL-1, i)' gives the correct ID bits per each row i of the ID block.
			//E.g., in a 4x2 window, in the first cycle we need bits 0-1 for row 1, while in the next cycle we need bits 2-3, so shift by COL=2 is needed.
			else {
				ID_reg = (ID_reg >> COL);
			}
		}
		//Output the ROW generated dimensions for subsequent pipelined search.
		//Note that we use quantized random projection. Otherwise, we will need higher bit-width for classes (and tmp resgiter during dot-product).
		for (int i = 0; i < ROW; i++) {
			//enc_stream[i].push(encHV_partial[i]);
			//if (iter_epoch == 0 && iter_read == 1)
				//cout << encHV_partial[i] << endl;
			if (encHV_partial[i] >= 0)
				enc_stream[r*ROW+i] = 1;
			else
				enc_stream[r*ROW+i] = -1;
		}
	}
}


/*
 * searchUnit is the major component of our implementation. It runs EPOCH times over the data.
 * First, it reads all the encoding hypervectors ROW by ROW (ROW elements in Div/COL cycles) from the encodeUnit unit, and stores them in the global memory to reuse in clustering.
 * Thereafter, it reads the encoded hypervector from the global memory.
 *
 * enc_stream (input): ROW parallel stream of bipolar (+1, -1) dimensions from encoding unit.
 * encHV_gmem (input/output): interface to write/read encoded hypervectors to/from the DRAM to reuse encoded data.
 * labels_gmem (output): final cluster index of each data sample.
 * EPOCH (input): number of iteration over data.
 * size (input): number of data samples.
 */

void searchUnit(int *__restrict enc_stream, int *__restrict labels_gmem, int EPOCH, int size, int *__restrict centerHV, int *__restrict centerHV_temp, float *__restrict norm2_inv, int iter_epoch, int iter_read) {

	//Explained previously: to read ROW encoding dimensions per cycle.
	//To store the dot-product of the centroid classes with the encoding hypervector.
	uint64_t dotProductRes[N_CENTER];

	//To store an encoding hypervector.
	int encHV_full[Dhv];

	//update the centroids in the next epochs
	if (iter_epoch > 0 && iter_read == 0) {
		for (int i_center = 0; i_center < N_CENTER; i_center++) {
			uint64_t total = 0;
			for (int dim = 0; dim < Dhv; dim++) {
				uint64_t temp = centerHV_temp[i_center*Dhv+dim];
				//centerHV[i_center][dim] = temp >= 0 ? 1 : -1;
				centerHV[i_center*Dhv+dim] = temp;
				centerHV_temp[i_center*Dhv+dim] = 0;
				total += temp*temp;
			}
			if (total == 0)
				norm2_inv[i_center] = 0;
			else {
				norm2_inv[i_center] = 1.0 / float(total);
			}
		}
	}

	//Reset the dotProductRes (score buffer) before each input sample.
	for (int i = 0; i < N_CENTER; i++) {
		dotProductRes[i] = 0;
	}

	//read one encoded HV
	for (int i_dim = 0; i_dim < Dhv; i_dim += ROW) {
		for (int j_sub = 0; j_sub < ROW; j_sub++) {
			encHV_full[i_dim + j_sub] = enc_stream[i_dim+j_sub];
		}
	}
	//Initialize the centroids in the first epoch
	//Choose first N_CENTER points as centroids
	if ((iter_epoch == 0) && (iter_read < N_CENTER)) {
		uint64_t total = 0;
		for (int dim = 0; dim < Dhv; dim++) {
			uint64_t temp = encHV_full[dim];
			centerHV[iter_read*Dhv+dim] = temp;
			centerHV_temp[iter_read*Dhv+dim] = 0;
			total += (temp*temp);
		}
		if (total == 0)
			norm2_inv[iter_read] = 0;
		else
			norm2_inv[iter_read] = 1.0/float(total);
		//cout << norm2_inv[iter_read] << endl;
	}
	else {//In the next epochs, or after the centorids are initialized
		//Compare the hypervector with all centroid hypervectors.
		for (int i_center = 0; i_center < N_CENTER; i_center++) {
			for (int dim = 0; dim < Dhv; dim++) {
				dotProductRes[i_center] += uint64_t(encHV_full[dim]) * uint64_t(centerHV[i_center*Dhv+dim]);
			}
		}
		//Find out the max index
		int maxIndex = 0;
		float maxVal;
		for (int i_center = 0; i_center < N_CENTER; i_center++) {
			float temp = dotProductRes[i_center]*norm2_inv[i_center];
			float score = temp * dotProductRes[i_center];
			if (dotProductRes[i_center] < 0)
				score = -score;
			if (!i_center || score > maxVal) {
				maxIndex = i_center;
				maxVal = score;
			}
		}
		//Add the encoded hypervector to the nearest temporary centroid
		for (int dim = 0; dim < Dhv; dim++) {
			centerHV_temp[maxIndex*Dhv+dim] += encHV_full[dim];
		}
		//If it is the last epoch, output the index of the centroid as the label of this input sample.
		if (iter_epoch == EPOCH-1) {
			labels_gmem[iter_read] = maxIndex;
		}
	}
}

void top(int *__restrict input_gmem, int *__restrict ID_gmem, int *__restrict labels_gmem, int EPOCH, int size) {

	int feature_stream[N_FEAT_PAD];

	//For now, the encoding stream is integer while we are using bipolar (+1, -1) encoding. Fix it later.
	int enc_stream[Dhv];

	//We have a seed ID of Dhv length, and we partition it to Dhv/ROW pieces of ROW bits as we operate on ROW rows at the same time.
	uint32_t ID[Dhv/ROW];

	//Initialize the seed ID hypervector
	int offset = 0;
	static_assert(ROW == 32, "In the Hetero-C++ port, ROW must be 32!");
	static_assert(COL == 8, "In the Hetero-C++ port, COL must be 8!");
	for (int i = 0; i < Dhv/32; i++) {
		uint32_t ID_int = ID_gmem[i];
		ID[i] = ID_int;
	}

	//Centroid hypervectors.
	int centerHV[N_CENTER][Dhv];

	//Temporary centroid class hypervectors to bundle the encoded hypervectors belonging to the same centroid.
	int centerHV_temp[N_CENTER][Dhv];
	//We partition each class dimensions into ROW elements to match the ROW generated dimensions.

	float norm2_inv[N_CENTER];

	for (int iter_epoch = 0; iter_epoch < EPOCH; iter_epoch++) {
		for (int iter_read = 0; iter_read < size; iter_read++) {
			inputStream(input_gmem, feature_stream, EPOCH, size, iter_epoch, iter_read);
			encodeUnit(feature_stream, ID, enc_stream, EPOCH, size, iter_epoch, iter_read);
			searchUnit(enc_stream, labels_gmem, EPOCH, size, &centerHV[0][0], &centerHV_temp[0][0], &norm2_inv[0], iter_epoch, iter_read);
		}
	}
}

/*
 * input_gmem (input): input data port; each feature is quantized to an integer.
 * ID_gmem (input): seed ID hypervector, packed to ints.
 * encHV_gmem (input/output): interface to write/read encoded hypervectors to/from the DRAM to reuse encoded data.
 * labels_gmem (output): final cluster of each data sample.
 * EPOCH (input): number of iteration over data.
 * size (input): number of data samples.
 */

void hd(int *__restrict input_gmem, std::size_t input_gmem_size, int *__restrict ID_gmem, std::size_t ID_gmem_size, int *__restrict labels_gmem, std::size_t labels_gmem_size, int EPOCH, int size) {
#ifdef HPVM
	void *root_Section = __hetero_section_begin();
	void *root_Wrapper = __hetero_task_begin(
					5,
					input_gmem, input_gmem_size, 
					ID_gmem, ID_gmem_size, 					
					labels_gmem, labels_gmem_size,
					EPOCH,
					size,
					3,
					input_gmem, input_gmem_size, 
					ID_gmem, ID_gmem_size, 					
					labels_gmem, labels_gmem_size,
					"root_task");

	void *hd_Section = __hetero_section_begin();
	void *hd_Wrapper = __hetero_task_begin(
					5,
					input_gmem, input_gmem_size, 
					ID_gmem, ID_gmem_size, 					
					labels_gmem, labels_gmem_size,
					EPOCH,
					size,
					3,
					input_gmem, input_gmem_size, 
					ID_gmem, ID_gmem_size, 					
					labels_gmem, labels_gmem_size,
					"hd_task");
	__hpvm__hint(DEVICE);
#endif

	top(input_gmem, ID_gmem, labels_gmem, EPOCH, size);

#ifdef HPVM
	__hetero_task_end(hd_Wrapper);
	__hetero_section_end(hd_Section);

	__hetero_task_end(root_Wrapper);
	__hetero_section_end(root_Section);
#endif
}

#if 0
void hd(int *__restrict input_gmem, std::size_t input_gmem_size, int *__restrict ID_gmem, std::size_t ID_gmem_size, int *__restrict labels_gmem, std::size_t labels_gmem_size, int EPOCH, int size) {
	// Create random projection encoding matrix (see encodeUnit for exactly how this is done currently)
	// Note, this hypermatrix may be too large to contain in memory all at once - encodeUnit (as far as I can tell) constructs it on
	// the fly when encoding a hypervector - maybe this is a transforming the compiler will have to perform?
	auto ID_hypervector = __hetero_hdc_create_hypervector(ID_gmem, ID_gmem_size / sizeof(int)); // just make a hypervector from a buffer
	auto ID_hypermatric = __hetero_hdc_random_hypermatrix(ID_hypervector); // random_hypermatrix should take one hypervector as a seed

	// Encode input using random projection
	// padding_func basically replaces inputStream
	auto encoded_hypervectors[iter_read];
	for (int iter_read = 0; iter_read < size; iter_read++) {
		// See inputStream for the padding scheme
		auto features_hypervector = __hetero_hdc_create_hypervector(4, padding_func, input_gmem + iter_read * N_FEAT_PAD, N_FEAT, PAD);
		// Do encoding
		encoded_hypervectors[iter_read] = __hetero_hdc_matmul(features, ID_matrix);
	}

	// Use first N_CENTER encoded hypervectors as initial cluster centers
	auto clusters = __hetero_hdc_create_hypervectors(2, create_clusters, encoded_hypervectors, N_CENTER);
	for (int iter_epoch = 0; iter_epoch < EPOCH; iter_epoch++) {
		for (int iter_read = 0; iter_read < size; iter_read++) {
			// __hetero_hdc_clustering isn't in slideshow yet? Look at comments in searchUnit to see what this might actually do
			// (lines 183-209)
			clusters = __hetero_hdc_clustering(clusters, encoded_hypervector[iter_read]);
		}
	}
}
#endif
