#!/bin/bash -e

git clone https://github.com/spack/spack
(cd spack && git checkout edb99a2b05865aca685c1401c90710428170c424)

export SPACK_DISABLE_LOCAL_CONFIG=1
export SPACK_USER_CACHE_PATH=/tmp/_spack_cache

. spack/share/spack/setup-env.sh

spack mirror add E4S https://cache.e4s.io
spack buildcache keys -it

spack -e . concretize -f | tee concretize.log
time spack -e . install

git clone https://github.com/llvm-doe-org/llvm-project
(
 cd llvm-project
 git checkout clacc/main
 git apply /clacc-patch.txt
)

mkdir -p build-cpu-0
cp cmake-cpu.sh build-cpu-0/
cd build-cpu-0
./cmake.sh
make -j32
make -j12 \
 check-clang-openacc \
 check-libacc2omp
