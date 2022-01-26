#!/bin/bash -e

spack load cuda@11.4.2
spack load cmake
spack load binutils
spack load hwloc
spack load libedit
spack load ncurses
spack load swig
spack load libelf

cmake \
 -DCMAKE_INSTALL_PREFIX=/llvm-install-gpu-0 \
 -DCMAKE_BUILD_TYPE=Release \
 -DLLVM_ENABLE_PROJECTS=clang \
 -DLLVM_ENABLE_RUNTIMES=openmp \
 -DLLVM_TARGETS_TO_BUILD="host;NVPTX" \
 -DCMAKE_C_COMPILER=gcc \
 -DCMAKE_CXX_COMPILER=g++ \
 /llvm-project/llvm
