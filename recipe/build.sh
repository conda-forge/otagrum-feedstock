#!/bin/sh

# RuntimeError: std::bad_cast on osx in FromPotential
sed -i'.bak' "s|dynamic_cast|static_cast|g" lib/src/Utils.cxx

cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
  -DCMAKE_UNITY_BUILD=ON \
  -DPython_FIND_STRATEGY=LOCATION \
  -DPython_ROOT_DIR=${PREFIX} \
  -B build -S .

cmake --build build --target install --parallel ${CPU_COUNT}

if test "$CONDA_BUILD_CROSS_COMPILATION" != "1"
then
  ctest --test-dir build -R pyinstallcheck --output-on-failure -j${CPU_COUNT} -E TabuList
fi
