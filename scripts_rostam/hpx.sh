#!/bin/bash
echo "this script is used for build hpx on rostam"
echo " build_mode?" 
read -p "build_mode: " mode
echo "machine?"
read -p "which machine: " machine
echo "cxx compiler?"
read -p "CXX comiler : " cpp
echo "c compiler?"
read -p "C compiler : " c
cd ~/
if [ ! -d "pkgs_auto" ]; then
		mkdir ~/pkgs_auto
fi
cd ~/pkgs_auto

if [ ! -d "hpx" ]; then
		echo "How do you want to clone,h or s?"
		read clone
		if [ "$clone" = "h" ]; then
				git clone https://github.com/STEllAR-GROUP/hpx.git
		else
				git clone git@github.com:STEllAR-GROUP/hpx.git
		fi
fi

stdlib=""
if [ "$cpp" = "clang++" ]; then
	stdlib="-stdlib=libc++"
fi

echo "$boost_root"

cd ~/pkgs_auto/hpx

if [ -d "build_${cpp}_${machine}_${mode}" ]; then
	rm -r -f build_${cpp}_${machine}_${mode}
fi

mkdir build_${cpp}_${machine}_${mode}
cd  build_${cpp}_${machine}_${mode}
cmake	\
-DCMAKE_C_COMPILER=${c} 	\
-DCMAKE_CXX_COMPILER=${cpp}	\
-DCMAKE_BUILD_TYPE=${mode}	\
-DHPX_WITH_MALLOC=tcmalloc	\
-DHPX_WITH_THREAD_LOCAL_STORAGE=ON	\
-DCMAKE_CXX_FLAGS=${stdlib}	\
-DHPX_WITH_THREAD_IDLE_RATES=ON	\
..
make core -j12





