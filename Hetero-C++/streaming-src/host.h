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

/**
template <typename T>
struct aligned_allocator
{
  using value_type = T;
  T* allocate(std::size_t num)
  {
    void* ptr = nullptr;
    if (posix_memalign(&ptr,4096,num*sizeof(T)))
      throw std::bad_alloc();
    return reinterpret_cast<T*>(ptr);
  }
  void deallocate(T* p, std::size_t num)
  {
    free(p);
  }
};
*/

#define N_CENTER		26	//number of centers. (e.g., isolet: 26,)
#define N_FEAT			616	//feature per input (e.g., isolet: 617)
#define Dhv				  512  //hypervectors length
#define N_SAMPLE 		6238

int EPOCH = 2;
bool shuffled = false;
std::string X_data_path = "../dataset/isolet_train_trainX.bin";
std::string y_data_path = "../dataset/isolet_train_trainY.bin";

