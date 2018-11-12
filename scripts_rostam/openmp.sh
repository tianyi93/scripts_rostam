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

cd ~/
if [ ! -d "pkgs_auto" ]; then
		mkdir ~/pkgs_auto
fi
cd ~/pkgs_auto

if [ ! -d "openmp" ]; then
		echo "How do you want to clone,h or s?"
		read clone
		if [ "$clone" = "h" ]; then
				git clone https://github.com/llvm-mirror/openmp.git
		else
				git clone git@github.com:llvm-mirror/openmp.git
		fi
fi

cd ~/pkgs_auto/openmp

if [ -d "build_${compiler_cxx}_${machine}_${mode}" ]; then
	rm -r -f build_${compiler_cxx}_${machine}_${mode}
fi

mkdir build_${compiler_cxx}_${machine}_${mode}
cd build_${compiler_cxx}_${machine}_${mode}

cmake -DCMAKE_BUILD_TYPE=${mode} \
-DCMAKE_CXX_COMPILER=${compiler_cxx}	\
-DCMAKE_C_COMPILER=${compiler_c} ..

make -j5





