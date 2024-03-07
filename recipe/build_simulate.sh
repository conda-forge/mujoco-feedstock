#!/bin/sh

rm -rf build_simulate
mkdir build_simulate
cd build_simulate

cmake ${CMAKE_ARGS} -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DBUILD_TESTING:BOOL=OFF \
      -DMUJOCO_ENABLE_AVX:BOOL=OFF \
      -DMUJOCO_SIMULATE_USE_SYSTEM_MUJOCO:BOOL=ON \
      -DMUJOCO_SIMULATE_USE_SYSTEM_GLFW:BOOL=ON \
      -DMUJOCO_EXTRAS_STATIC_GLFW:BOOL=OFF \
      -DMUJOCO_SIMULATE_INSTALL:BOOL=ON \
      -DMUJOCO_ENABLE_RPATH:BOOL=OFF \
      -DSIMULATE_COMMAND_PREFIX:STRING="mujoco-" \
      ${SRC_DIR}/simulate

cmake --build . --config Release

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  ctest --output-on-failure -C Release
fi

cmake --build . --config Release --target install
