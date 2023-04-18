This repository contains a Hetero-C++ port of the HD-Clustering code from UCSD. Here are the steps taken to port the Xilinx Vitis HLS C++ code to Hetero-C++:

1. Remove all Vitis specific constructs. In this codebase, the primary Vitis constructs used were hls::stream and ap_int<N>, where N is any number of bits.
- To replace ap_int, convert any ap_int<N> to the corresponding uintN_t, assuming N is 8, 16, 32, or 64 (this is the vast majority of cases)
- For ap_int<N> where N is large (in the code, the common case is N = 512), convert the ap_int<N> to an array of uintN_t (in the HD-Classification code, I converted ap_int<512> to uint32_t[8], which is easy since most references to ap_int<512> were through pointers, so all that needs to change is some pointer math)
- To replace hls::stream, code re-structuring is required - the FPGA code is structured as separate kernels that communicate in a streaming mannger, removing the hls::streams requires de-streaming the code
- If each kernel has a common outer iteration, this can be achieved by moving the loop outside of the kernels (so in top, do for { kernel1(); kernel2(); } rather than kernel1 and kernel2 containing the for loop), then each kernel communicates through a shared buffer (input of one kernel, input to another)
- In some cases, more aggressive code restructuring might be required (as in the HD-Classification code) - this was due to differing loop structures between the kernels, unfortunately the code restructuring in these cases is fairly case specific - the goal is to minimize the amount of data communicated between the kernels between invocations, as a whole buffer has to be allocated for that amount of data
2. Add Hetero-C++ annotations, and launch from the host code.
- This part is fairly straightforward, since the HD codes by-and-large don't contain task level parallelism, so the whole HD code can be modeled as a single HPVM leaf node
- To run on FPGA, the leaf node needs a CPU internal node wrapper (see the hd function in hd.cpp for an example of our to set this up in Hetero-C++)
- The inputs and outputs of the kernel should be annotated in hd.cpp, and should match up with how the DFG is launched in host.cpp
- Mark all pointer arguments as restrict (if an argument was an array, convert to a restrict pointer) to get better performance
