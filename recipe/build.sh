#!/bin/sh

if test `uname` == "Darwin"; then
  export CXXFLAGS="${CXXFLAGS} -fno-assume-unique-vtables"
fi

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
  -DCMAKE_UNITY_BUILD=ON \
  -DPython_FIND_STRATEGY=LOCATION \
  -DPython_ROOT_DIR=${PREFIX} \
  -DSWIG_COMPILE_FLAGS="-O1 -DPy_LIMITED_API=0x030A0000" -DUSE_PYTHON_SABI=ON \
  -B build .

cmake --build build --target install --parallel ${CPU_COUNT}

if test "$CONDA_BUILD_CROSS_COMPILATION" != "1"
then
  ctest --test-dir build -R pyinstallcheck --output-on-failure -j${CPU_COUNT} -E TabuList
fi
