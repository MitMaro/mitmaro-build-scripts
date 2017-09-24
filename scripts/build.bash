#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BUILD_DIRECTORY="build/"
OUTPUT_FILE="build-scripts.bash"
BUILD_OUTPUT="$BUILD_DIRECTORY${OUTPUT_FILE}"

mkdir -p "$BUILD_DIRECTORY"
echo src/*.bash | xargs cat > "$BUILD_OUTPUT"

bash "$BUILD_OUTPUT"
