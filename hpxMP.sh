#!/bin/bash
echo "this script is used for build hpxMP on rostam"
echo " build_mode?" 
read -p "build_mode: " mode
echo "machine?"
read -p "which machine: " machine
echo "cxx compiler?"
read -p "CXX comiler : " compiler_cxx
echo "c compiler?"
read -p "C compiler : " compiler_c

cd ../hpxMP
mkdir build_${compiler_cxx}_${machine}_${mode}
cd build_${compiler_cxx}_${machine}_${mode}

cmake -DCMAKE_BUILD_TYPE=${mode} \
-DCMAKE_CXX_COMPILER=${compiler_cxx}	\
-DCMAKE_C_COMPILER=/opt/mn/clang/6.0.1/bin/${compiler_c}	\
-DCMAKE_ASM_COMPILER=${compiler_c}	\
-DHPX_DIR=/home/tzhang/hpx/build_${compiler_cxx}_${machine}_${mode}/lib/cmake/HPX 	\
-DCMAKE_CXX_FLAGS=-stdlib=libc++ ..

make -j5

