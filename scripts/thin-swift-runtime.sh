#!/usr/bin/env bash

set -e
set -x

XCODE_PATH="/Applications/Xcode"
SWIFT_RUNTIME_PATH="${XCODE_PATH}/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/iphoneos"
DEST_PATH="Resources/Frameworks"

rm -f "${DEST_PATH}/libswift*.dylib"

find "${SWIFT_RUNTIME_PATH}" -type f -name "*.dylib" -print0 | while IFS= read -r -d $'\0' DYLIB; do
  DYLIB_NO_EXT="${DYLIB%.dylib}"
  DYLIB_NO_EXT_BASENAME=$(basename "${DYLIB_NO_EXT}")
  DEST_DYLIB_NO_EXT="${DEST_PATH}/${DYLIB_NO_EXT_BASENAME}"
  lipo -thin armv7 -output "${DEST_DYLIB_NO_EXT}.armv7" "${DYLIB}"
  lipo -thin arm64 -output "${DEST_DYLIB_NO_EXT}.arm64" "${DYLIB}"
  lipo "${DEST_DYLIB_NO_EXT}.armv7" "${DEST_DYLIB_NO_EXT}.arm64" -output "${DEST_DYLIB_NO_EXT}.dylib" -create
  rm "${DEST_DYLIB_NO_EXT}.armv7" "${DEST_DYLIB_NO_EXT}.arm64"
done

rm -f "${DEST_PATH}/libswiftXCTest.dylib" 
rm -f "${DEST_PATH}/libswiftWatchKit.dylib" 
