#!/bin/sh

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cd $SRC_DIR/python
bash make_sdist.sh
cd dist
export MUJOCO_PATH=$PREFIX
export MUJOCO_PLUGIN_PATH=$PREFIX/bin/mujoco_plugin
export MUJOCO_CMAKE_ARGS=$CMAKE_ARGS
python -m pip install --no-deps mujoco-*.tar.gz
