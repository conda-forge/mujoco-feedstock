#!/bin/sh

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cd $SRC_DIR/python
# Workaround for missing pxr import https://github.com/conda-forge/mujoco-feedstock/pull/62
rm -rf ./mujoco/usd/exporter_test.py
bash make_sdist.sh
cd dist
export MUJOCO_PATH=$PREFIX
export MUJOCO_PLUGIN_PATH=$PREFIX/bin/mujoco_plugin
export MUJOCO_CMAKE_ARGS="-DMUJOCO_PYTHON_USE_SYSTEM_PYBIND11:BOOL=ON $CMAKE_ARGS"
python -m pip install --no-deps mujoco-*.tar.gz
