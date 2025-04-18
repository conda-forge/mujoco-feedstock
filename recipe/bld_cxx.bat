set "CC=clang-cl.exe"
set "CXX=clang-cl.exe"

mkdir build_cxx
cd build_cxx

cmake ^
    -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DBUILD_TESTING:BOOL=OFF ^
    -DMUJOCO_BUILD_TESTS:BOOL=ON ^
    -DMUJOCO_BUILD_SIMULATE:BOOL=OFF ^
    -DMUJOCO_BUILD_EXAMPLES:BOOL=OFF ^
    -DMUJOCO_ENABLE_AVX:BOOL=OFF ^
    -DMUJOCO_ENABLE_AVX_INTRINSICS:BOOL=OFF ^
    -DCMAKE_INTERPROCEDURAL_OPTIMIZATION:BOOL=OFF ^
    -DMUJOCO_INSTALL_PLUGINS:BOOL=ON ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Test.
ctest --output-on-failure -C Release 
if errorlevel 1 exit 1
