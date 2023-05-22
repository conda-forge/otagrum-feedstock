#!/bin/sh

mkdir build && cd build

cmake \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
  -DPython_FIND_STRATEGY=LOCATION \
  -DPython_ROOT_DIR=${PREFIX} \
  ..

make install -j${CPU_COUNT}
ctest -R pyinstallcheck --output-on-failure -j${CPU_COUNT} -E "TabuList"
