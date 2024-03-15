#!/bin/sh

rm -rf build_samples
mkdir build_samples
cd build_samples

cmake ${CMAKE_ARGS} -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DMUJOCO_ENABLE_AVX:BOOL=${MUJOCO_ENABLE_AVX} \
      -DMUJOCO_ENABLE_AVX_INTRINSICS:BOOL=${MUJOCO_ENABLE_AVX} \
      -DMUJOCO_SAMPLES_USE_SYSTEM_MUJOCO:BOOL=ON \
      -DMUJOCO_SAMPLES_USE_SYSTEM_GLFW:BOOL=ON \
      -DMUJOCO_EXTRAS_STATIC_GLFW:BOOL=OFF \
      -DMUJOCO_SAMPLES_INSTALL:BOOL=ON \
      -DMUJOCO_ENABLE_RPATH:BOOL=OFF \
      -DMUJOCO_SAMPLE_COMMAND_PREFIX:STRING="mujoco-" \
      ${SRC_DIR}/sample

cmake --build . --config Release

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  ctest --output-on-failure -C Release
fi

cmake --build . --config Release --target install
