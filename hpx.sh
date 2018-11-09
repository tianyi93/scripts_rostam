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
cd ~/
if [ ! -d "pkgs_auto" ]; then
		mkdir ~/pkgs_auto
		cd ~/pkgs_auto
fi
if [ ! -d "hpx" ]; then
		echo "How do you want to clone,h or s?"
		read clone
		if [ "$clone"="h"]
				git clone https://github.com/STEllAR-GROUP/hpx.git
		else
				git clone git@github.com:STEllAR-GROUP/hpx.git
		fi
fi

cd ~/pkgs/hpx

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
make core -j12


