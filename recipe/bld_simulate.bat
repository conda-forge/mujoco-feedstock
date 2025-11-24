mkdir build_simulate
cd build_simulate

cmake ^
    -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DMUJOCO_ENABLE_AVX:BOOL=OFF ^
    -DMUJOCO_SIMULATE_USE_SYSTEM_MUJOCO:BOOL=ON ^
    -DMUJOCO_SIMULATE_USE_SYSTEM_GLFW:BOOL=ON ^
    -DMUJOCO_EXTRAS_STATIC_GLFW:BOOL=OFF ^
    -DMUJOCO_ENABLE_RPATH:BOOL=OFF ^
    -DSIMULATE_COMMAND_PREFIX:STRING="mujoco-" ^
    -DCMAKE_PROJECT_TOP_LEVEL_INCLUDES=%RECIPE_DIR%\fetchcontent_to_find_package_provider.cmake ^
    %SRC_DIR%/simulate
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
