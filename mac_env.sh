export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export LIBRARY_PATH="$LIBRARY_PATH:$SDKROOT/usr/lib"
export CFLAGS="$(pkg-config --cflags sdl3) -I$SDKROOT/usr/include"
export LDFLAGS=`pkg-config --libs sdl3`