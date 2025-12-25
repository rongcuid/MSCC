export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export LIBRARY_PATH="$LIBRARY_PATH:$SDKROOT/usr/lib"
export SDL3_CFLAGS="$(pkg-config --cflags sdl3) -I$SDKROOT/usr/include"
export SDL3_LDFLAGS=`pkg-config --libs sdl3`