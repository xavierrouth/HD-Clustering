INCLUDES := -I$(HPVM_INSTALL_DIR)/include -I$(HPVM_INSTALL_DIR)/benchmarks/include -I$(HPVM_INSTALL_DIR)/projects/hpvm-hdc -I./streaming-src

HPVM_LIB := $(HPVM_INSTALL_DIR)/build/lib
HPVM_BIN := $(HPVM_INSTALL_DIR)/build/bin

HPVM_DECLS_FILE := $(HPVM_BUILD_DIR)/tools/hpvm/projects/hetero-c++/lib/HPVMCFunctionDeclarations/HPVMCFunctionDeclarations.bc

CUDA_PATH:=/software/cuda-9.1
OPENCL_PATH:=$(CUDA_PATH)
OPENCL_LIB_PATH:=$(OPENCL_PATH/lib64)

CFLAGS := -O1 -fenable-matrix -ftime-report -fno-discard-value-names -fno-exceptions

# PARAMETERS := -DHPVM -DDEVICE=hpvm::CPU_TARGET

# Generate Executable
host-cpu: build/output.ll
	$(HPVM_INSTALL_DIR)/build/bin/clang++ -I$(OPENCL_PATH)/include/CL -L$(OPENCL_LIB_PATH) -lm -lrt -pthread -lOpenCL -O1 $< -o $@

# Clang Frontend to IR
build/host.cpu.ll: streaming-src/host.cpp
	$(HPVM_BIN)/clang++ -DHPVM -DDEVICE=hpvm::CPU_TARGET $(CFLAGS) $(INCLUDES) -S -emit-llvm $^ -o $@ 

build/hpvmc.cpu.ll: build/host.cpu.ll
	$(HPVM_BIN)/hcc $< -declsfile $(HPVM_DECLS_FILE) -sanitise-funcs --dot-dfg -S -o $@

# GenHPVM and mem2reg
build/hpvm.cpu.ll: build/hpvmc.cpu.ll
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/HPVMGenHPVM.so -inline -mem2reg -genhpvm $< -S -o $@

# Lower HDC Intrinsics
build/hdclowered.cpu.ll: build/hpvm.cpu.ll #hpvm.
	$(HPVM_BIN)/opt -enable-new-pm=0 -load $(HPVM_LIB)/LLVMHPVMHDC.so -debug -lower-hdc $< -S -o $@

# Other HPVM Passes
build/hpvmcompiled.cpu.ll: build/hdclowered.cpu.ll
	$(HPVM_INSTALL_DIR)/build/bin/opt -enable-new-pm=0 -load $(HPVM_LIB)/HPVMBuildDFG.so -load $(HPVM_LIB)/HPVMDFG2LLVM_CPU.so -load $(HPVM_LIB)/HPVMClearDFG.so -load $(HPVM_LIB)/HPVMDFGTransformPasses.so -dfg2llvm-cpu -clearDFG -hpvm-timers-cpu $< -S -o $@

HPVM_RT := $(HPVM_BUILD_DIR)/tools/hpvm/projects/hpvm-rt/hpvm-rt.bc

# LINK HPVM RT and DCE
build/output.ll: build/hpvmcompiled.cpu.ll # build/cpu_test.hpvmcompiled.ll
	$(HPVM_INSTALL_DIR)/build/bin/llvm-link $< $(HPVM_RT) -S -o $@ 
	$(HPVM_INSTALL_DIR)/build/bin/opt -dce -globaldce $< -S -o $<

.PHONY: clean

clean:
	rm -rf build/*.ll