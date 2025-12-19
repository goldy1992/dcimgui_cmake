# DCIMGUI C API

- This repository generates a C API for IMGUI and has a `CMakeLists.txt` to be able to generate a static or dynamic library.
- `imgui` and the corresponding `dear_bindings` repository are included as submodules within the `deps` directory.
- Regeneration of the api is _only required_ for creating branches for new releases.
- The generated files are submitted into version control.

## Selecting a Backend
_*Prerequisite*_: Ensure your backend link libraries are available in the CMake Project, e.g. GLFW/SDL etc.
Edit the `CMakeLists.txt` via the following steps:
1. Add a list of the backend imgui AND dcimgui files, e.g.
```
set(OPENGL3)
list(APPEND OPENGL3
   backends/dcimgui_impl_opengl3.cpp
   backends/imgui_impl_opengl3.cpp
   backends/imgui_impl_opengl3_loader.h
)
```
2. Add the list to the library sources ensuring to include `$IMGUI_FILES`, e.g.
```
add_library(${DCIMGUI} 
    ${IMGUI_FILES}
    ${OPENGL3} # Add OPENGL3
)
```
3. Link any external dependencies:
```
target_link_libraries(${DCIMGUI} PUBLIC
    glfw # links against GLFW
)
```
- Add the corresponding backend to the CMake library sources

## API Generation Requirements
- Python (> 3.10), as per `dear_bindings`

Then run the `build.ps1` or alternate shell script to generate the CMake library.