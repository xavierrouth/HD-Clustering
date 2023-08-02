INCLUDES := -I$(HPVM_INSTALL_DIR)/include -I$(HPVM_INSTALL_DIR)/benchmarks/include -I$(HPVM_INSTALL_DIR)/projects/hpvm-hdc/cpu-impl/  -I./streaming-src

CFLAGS := -fenable-matrix -ftime-report -fno-discard-value-names --hetero-cc -Hdot-dfg -debug --hpvm-target cpu -v 

PARAMETERS := -DHPVM -DDEVICE=hpvm::CPU_TARGET

build/host.cpu : streaming-src/host.cpp  src/host.h
	hpvm-clang $(PARAMETERS) $(CFLAGS) $(INCLUDES) -d tmp/ -o $@ streaming-src/host.cpp
