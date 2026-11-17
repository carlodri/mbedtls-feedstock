#!/bin/bash
set -ex

mkdir build

# The compiler activation may pass bare tool names, e.g.
# -DCMAKE_AR=x86_64-conda-linux-gnu-ar. Mbed TLS requires CMake 3.5.1, which
# leaves CMP0125 unset, so CMake would resolve those names against the current
# directory instead of searching PATH.
CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_POLICY_DEFAULT_CMP0125=NEW"

if [[ "$target_platform" == osx-arm64 ]]; then
	cmake -B build -S . \
		${CMAKE_ARGS} \
		-DCMAKE_INSTALL_PREFIX=$PREFIX \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_VERBOSE_MAKEFILE=ON \
		-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
		-DENABLE_PROGRAMS=OFF \
		-DENABLE_TESTING=OFF
elif [[ "$target_platform" == osx-64 ]]; then
	cmake -B build -S . \
		${CMAKE_ARGS} \
		-DCMAKE_INSTALL_PREFIX=$PREFIX \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_VERBOSE_MAKEFILE=ON \
		-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
		-DENABLE_PROGRAMS=OFF \
		-DENABLE_TESTING=OFF \
  		-D_POSIX_C_SOURCE=199309L
else	
 	cmake -B build -S . \
		${CMAKE_ARGS} \
		-DCMAKE_INSTALL_PREFIX=$PREFIX \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_VERBOSE_MAKEFILE=ON \
		-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
		-DENABLE_PROGRAMS=OFF \
		-DENABLE_TESTING=OFF \
		-DCMAKE_C_FLAGS="-Wno-stringop-overflow -Wno-error=array-bounds" \
    	-DCMAKE_CXX_FLAGS="-Wno-stringop-overflow -Wno-error=array-bounds"
fi

cmake --build build
cmake --install build
