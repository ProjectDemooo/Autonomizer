CPP = g++
CPPFLAGS = -Wall -Wno-sign-compare -O2 -c -g -fPIC -std=c++11 -I/usr/include/python2.7 -I/usr/local/lib/python2.7/dist-packages/numpy/core/include/
SHARED_FLAGS = -shared -fPIC

GCC = gcc 
CFLAGS = -Wall -O2 -c -g -I/usr/include/python2.7 -I/usr/local/lib/python2.7/dist-packages/numpy/core/include/

LD_FLAGS = -lrt -lpython2.7

SRCPP = ProgIntel.cpp \
				FileIO.cpp \
				PyInterface/PyInterface.cpp \
				CheckPoint/CPIO.cpp \
				CheckPoint/CPClient.cpp 
				
SRCPP2 = CheckPoint/CPServer.cpp \
				 CheckPoint/CPIO.cpp

# Test Client
SRCPP3 = CheckPoint/CPClient.cpp \
				 CheckPoint/CPIO.cpp

OBJC = $(patsubst %.c, %.o, $(SRC))
OBJCPP = $(patsubst %.cpp, %.o, $(SRCPP))
OBJCPP2 = $(patsubst %.cpp, %.o, $(SRCPP2))
OBJCPP3 = $(patsubst %.cpp, %.o, $(SRCPP3))


MOD_PATH = $(CURDIR)/PyInterface/

all: $(OBJC) $(OBJCPP) $(OBJCPP2) $(OBJCPP3)
	@echo Building library
	$(CPP) $(SHARED_FLAGS) -o libPI.so $(OBJCPP) $(LD_FLAGS)
	$(CPP) -o ckptServer $(OBJCPP2) -lvirt
	#$(CPP) -o ckptClient $(OBJCPP3)

%.o: %.cpp
	@echo Compiling $*.cpp
	$(CPP) $(CPPFLAGS) -DPY_MOD_PATH='"$(MOD_PATH)"' $< -o $@

%.o: %.c
	@echo Compiling $*.c
	$(GCC) $(CFLAGS) -DDP_MOD_PATH='"$(MOD_PATH)"' $< -o $@

.PHONY: all clean

clean:
	rm -f *.o *.so PyInterface/*.o cpkt* CheckPoint/*.o
