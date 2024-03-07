mkdir build_samples
cd build_samples

cmake ^
    -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DMUJOCO_ENABLE_AVX:BOOL=OFF ^
    -DMUJOCO_SAMPLES_USE_SYSTEM_MUJOCO:BOOL=ON ^
    -DMUJOCO_SAMPLES_USE_SYSTEM_GLFW:BOOL=ON ^
    -DMUJOCO_EXTRAS_STATIC_GLFW:BOOL=OFF ^
    -DMUJOCO_SAMPLES_INSTALL:BOOL=ON ^
    -DMUJOCO_ENABLE_RPATH:BOOL=OFF ^
    -DMUJOCO_SAMPLE_COMMAND_PREFIX:STRING="mujoco-" ^
    %SRC_DIR%/sample
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
