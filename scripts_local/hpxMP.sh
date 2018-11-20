#!/bin/bash
echo "this script is used for build hpxMP on local machine"
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

if [ ! -d "hpxMP" ]; then
		echo "How do you want to clone,h or s?"
		read clone
		if [ "$clone" = "h" ]; then
				git clone https://github.com/STEllAR-GROUP/hpxMP.git
		else
				git clone git@github.com:STEllAR-GROUP/hpxMP.git
		fi
fi

cd ~/pkgs_auto/hpxMP

if [ -d "build_${compiler_cxx}_${machine}_${mode}" ]; then
	rm -r -f build_${compiler_cxx}_${machine}_${mode}
fi

mkdir build_${compiler_cxx}_${machine}_${mode}
cd build_${compiler_cxx}_${machine}_${mode}

stdlib=""

if [ "$compiler_cxx" = "clang++" ]; then
	echo "clang++"
#	stdlib="-stdlib=libc++"
fi

echo "${stdlib}"

cmake -DCMAKE_BUILD_TYPE=${mode} \
-DCMAKE_CXX_COMPILER=${compiler_cxx}	\
-DCMAKE_C_COMPILER=${compiler_c}	\
-DHPX_DIR=~/pkgs_auto/hpx/build_${compiler_cxx}_${machine}_${mode}/lib/cmake/HPX 	\
-DCMAKE_CXX_FLAGS=${stdlib}	\
-DCMAKE_ASM_COMPILER=${compiler_c} ..

make -j5
make test

