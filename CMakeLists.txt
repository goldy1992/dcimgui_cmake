cmake_minimum_required(VERSION 3.22.1...3.31.7 )
project(dcimgui_cmake)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Vulkan REQUIRED)
if(NOT TARGET glfw)
    find_package(glfw REQUIRED)
endif()

set(DCIMGUI_OPENGL3)
list(APPEND DCIMGUI_OPENGL3
   backends/dcimgui_impl_opengl3.cpp
   backends/imgui_impl_opengl3.cpp
   backends/imgui_impl_opengl3_loader.h
)
set(DCIMGUI_VULKAN)
list(APPEND DCIMGUI_VULKAN 
   backends/dcimgui_impl_vulkan.cpp
   backends/dcimgui_impl_vulkan.h
   backends/imgui_impl_vulkan.h
   backends/imgui_impl_vulkan.cpp
)
set(DCIMGUI_GLFW)
list(APPEND DCIMGUI_GLFW 
   backends/imgui_impl_glfw.cpp
   backends/imgui_impl_glfw.h
   backends/dcimgui_impl_glfw.cpp
   backends/dcimgui_impl_glfw.h
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

# OPENGL3
add_library(dcimgui_glfw_opengl3
    ${IMGUI_FILES}
    ${DCIMGUI_OPENGL3}
    ${DCIMGUI_GLFW}
)
target_include_directories(dcimgui_glfw_opengl3 PUBLIC 
    ${CMAKE_CURRENT_LIST_DIR}  
    ${CMAKE_CURRENT_LIST_DIR}/backends
)
target_link_libraries(dcimgui_glfw_opengl3 PUBLIC
    glfw
)

# VULKAN 
add_library(dcimgui_glfw_vulkan
    ${IMGUI_FILES}
    ${DCIMGUI_VULKAN}
    ${DCIMGUI_GLFW}
)
target_include_directories(dcimgui_glfw_vulkan PUBLIC 
    ${CMAKE_CURRENT_LIST_DIR}  
    ${CMAKE_CURRENT_LIST_DIR}/backends
)
target_link_libraries(dcimgui_glfw_vulkan PUBLIC
    glfw
    Vulkan
)
