#!/bin/sh

cd $SRC_DIR/python
bash make_sdist.sh
cd dist
export MUJOCO_PATH=$PREFIX
export MUJOCO_PLUGIN_PATH=$PREFIX/bin/mujoco_plugin
python -m pip install --no-deps mujoco-*.tar.gz
