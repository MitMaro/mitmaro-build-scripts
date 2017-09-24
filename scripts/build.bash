#!/usr/bin/env bash

BUILD_DIRECTORY="build/"
OUTPUT_FILE="build-scripts.bash"
BUILD_OUTPUT="$BUILD_DIRECTORY/${OUTPUT_FILE}"

mkdir -p "$BUILD_DIRECTORY"
echo src/*.bash | xargs cat > "$BUILD_OUTPUT"

chmod +x "$BUILD_OUTPUT"
"./$BUILD_OUTPUT"
