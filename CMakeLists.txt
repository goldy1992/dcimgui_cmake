cmake_minimum_required(VERSION 3.22.1...3.31.7 )
project(dcimgui_cmake)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Backend Defintions

# STEP 1 - ADD A BACKEND LIKE BELOW
set(OPENGL3)
list(APPEND OPENGL3
   backends/dcimgui_impl_opengl3.cpp
   backends/imgui_impl_opengl3.cpp
   backends/imgui_impl_opengl3_loader.h
)
set(GLFW)
list(APPEND GLFW 
   backends/imgui_impl_glfw.cpp
   backends/dcimgui_impl_glfw.cpp
)

set(IMGUI_FILES)
list(APPEND IMGUI_FILES
    dcimgui.h
    dcimgui.cpp
    dcimgui_internal.cpp
    imconfig.h
    imgui_demo.cpp
    imgui_draw.cpp
    imgui_tables.cpp
    imgui_widgets.cpp
    imgui.h
    imgui.cpp
    imgui_internal.h
    imstb_rectpack.h
    imstb_textedit.h
    imstb_truetype.h
)

set(DCIMGUI "dcimgui")

# STEP 2 - ADD THE SOURCES TO CMAKE
add_library(${DCIMGUI} 
    ${IMGUI_FILES}
    ${OPENGL3}
    ${GLFW}
)

target_include_directories(${DCIMGUI} PUBLIC 
    ${CMAKE_CURRENT_LIST_DIR}  
    ${CMAKE_CURRENT_LIST_DIR}/backends
)

# Step 3 - LINK ANY EXTERNAL LIBRARIES (e.g. glfw/SDL etc.)
target_link_libraries(${DCIMGUI} PUBLIC
    # GLAD
    glfw
)
