#!/bin/bash

SDL2_VERSION="2.0.12"

pushd app/jni/SDL

wget https://www.libsdl.org/release/SDL2-${SDL2_VERSION}.zip
unzip -q SDL2-${SDL2_VERSION}.zip
mv SDL2-${SDL2_VERSION}/src src
mv SDL2-${SDL2_VERSION}/include include

#MSYS2's symlinks seem to just copy the folder which isn't really a good thing recursively. Native symlinks are broken for me so let's just use Windows's implementation
if [[ -n "$WINDIR" ]]; then
    cmd <<< "mklink /D include\SDL2 ."
    echo "if mklink failed, you need to excecute the command at the root of the project as administrator in windows command prompt."
else
    ln -s . include/SDL2
fi

rm SDL2-${SDL2_VERSION}.zip
rm -r SDL2-${SDL2_VERSION}

popd
