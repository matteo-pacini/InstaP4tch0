#!/usr/bin/env bash

shopt -s globstar
shopt -s nullglob
shopt -s dotglob

for lib in ../Resources/Frameworks/*.dylib
do
  libnoext="${lib%.dylib}"
  lipo -thin armv7 -output "$libnoext.armv7" "$lib"
  lipo -thin arm64 -output "$libnoext.arm64" "$lib"
  rm $lib
  lipo "$libnoext.armv7" "$libnoext.arm64" -output "$lib" -create
  rm "$libnoext.armv7" "$libnoext.arm64"
done
