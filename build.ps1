$CURRENT_PATH = $PWD.path 
$IMGUI_PATH = $CURRENT_PATH
$OUTPUT_PATH = $CURRENT_PATH
echo "Running build with: "
echo "IMGUI_PATH as $IMGUI_PATH"
echo "OUTPUT_PATH as $OUTPUT_PATH"
echo "..."
echo "Copying imgui backends"
copy -Recurse deps/imgui/backends .
echo "Copying imgui cpp files"
copy -r deps/imgui/**.cpp .
echo "Copying imgui header files"
copy -r deps/imgui/**.h .

echo "Activating the python venv"
.\.venv\Scripts\Activate.ps1
echo "installing dear_bindings requirements.txt"
pip install -r deps/dear_bindings/requirements.txt
cd deps/dear_bindings
echo "Generating Bindings"
$DCIMGUI = "dcimgui"
echo "Generating ${DCIMGUI}.h"
python dear_bindings.py -o "$OUTPUT_PATH/$DCIMGUI" "$IMGUI_PATH/imgui.h" 

$DCIMGUI_INTERNAL = "dcimgui_internal"
echo "Generating dcimgui_internal.h"
python dear_bindings.py -o "$OUTPUT_PATH/$DCIMGUI_INTERNAL" --include "$IMGUI_PATH/imgui.h" "$IMGUI_PATH/imgui_internal.h" 

echo "Generating backends"
$BACKENDS = @(
    "allegro5",
    "android",
    "dx9",
    "dx10",
    "dx11",
    "dx12",
    "glfw",
    "glut",
    "opengl2",
    "opengl3",
    "sdl2",
    "sdlrenderer2",
    "sdl3",
    "sdlrenderer3",
    "vulkan",
    "wgpu",
    "win32"
)

for ($i = 0; $i -lt $BACKENDS.Length; $i++) {
    $CURRENT_BACKEND = $($BACKENDS[$i])
    echo "Generating $CURRENT_BACKEND"
    python dear_bindings.py --backend --include "$IMGUI_PATH/imgui.h" --imconfig-path "$IMGUI_PATH/imconfig.h" -o "$OUTPUT_PATH/backends/dcimgui_impl_$CURRENT_BACKEND" "$IMGUI_PATH/backends/imgui_impl_$CURRENT_BACKEND.h" 
}

cd $CURRENT_PATH
