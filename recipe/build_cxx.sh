#!/bin/sh

rm -rf build_cxx
mkdir build_cxx
cd build_cxx

env

cmake ${CMAKE_ARGS} -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DBUILD_TESTING:BOOL=OFF \
      -DMUJOCO_BUILD_TESTS:BOOL=ON \
      -DMUJOCO_BUILD_SIMULATE:BOOL=OFF \
      -DMUJOCO_BUILD_EXAMPLES:BOOL=OFF \
      -DMUJOCO_ENABLE_AVX:BOOL=${MUJOCO_ENABLE_AVX} \
      -DMUJOCO_ENABLE_AVX_INTRINSICS:BOOL=${MUJOCO_ENABLE_AVX} \
      -DCMAKE_INTERPROCEDURAL_OPTIMIZATION:BOOL=ON \
      -DMUJOCO_INSTALL_PLUGINS:BOOL=ON \
      $SRC_DIR

cmake --build . --config Release

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  ctest --output-on-failure -C Release
fi

cmake --build . --config Release --target install
