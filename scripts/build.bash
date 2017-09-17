#!/usr/bin/env bash

BUILD_DIRECTORY="build/"
OUTPUT_FILE="build-scripts.bash"

mkdir -p "$BUILD_DIRECTORY"
echo src/*.bash | xargs cat > "$BUILD_DIRECTORY/${OUTPUT_FILE}"
chmod +x "$BUILD_DIRECTORY/${OUTPUT_FILE}"
