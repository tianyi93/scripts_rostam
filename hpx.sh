#!/bin/bash
echo "this script is used for build hpx on rostam"
echo " build_mode?" 
read -p "build_mode: " mode
echo "machine?"
read -p "which machine: " machine
echo "cxx compiler?"
read -p "CXX comiler : " compiler_cxx
echo "c compiler?"
read -p "C compiler : " comiler_c
cd ../hpx
mkdir build_${compiler_cxx}_${machine}_${mode}
cd  build_${compiler_cxx}_${machine}_${mode}
cmake	\
-DCMAKE_CXX_COMPILER=${compiler_cxx} \
-DCMAKE_C_COMPILER=${compiler_c} \
-DCMAKE_CXX_FLAGS=-stdlib=libc++ \
-DCMAKE_BUILD_TYPE=${mode} \
-DHPX_WITH_MALLOC=tcmalloc	\
-DHPX_WITH_THREAD_LOCAL_STORAGE=ON	\
..
make -j12
