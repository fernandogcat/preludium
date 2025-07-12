#!/usr/bin/env bash

# Usage on mac when godot is an alias (since aliases are not available on shell scripts):
# > . scripts/build_with_godot.sh osx ./Builds/osx/export_name.app debug v0.9.0-0

# if called with incorrect number of arguments, print usage
if [ "$#" -lt 3 ]; then
  printf "Need arguments. Usage example: . scripts/build_with_godot.sh osx ./Builds/osx/export_name.app debug v0.9.0-0\n"
  return
fi

PLATFORM=$1
OUTPUT_FILE=$2
BUILD_MODE=$3
LOCAL_VERSION=$4

# if mode is not specified, set release as default
if [ -z "$BUILD_MODE" ]; then
  BUILD_MODE="release"
fi

if [ -z "$LOCAL_VERSION" ]; then
  LOCAL_VERSION="find_local_version"
fi

valid_modes="debug release"
if [[ ! "$valid_modes" =~ "$BUILD_MODE" ]]; then
  echo "Builds mode '$BUILD_MODE' is not valid. Use one of: $valid_modes"
  exit 1
fi

# check for platform and output file
if [ -z "$PLATFORM" ] || [ -z "$OUTPUT_FILE" ]; then
  printf "Required parameters not provided\n. Usage: ./build_with_godot.sh win ./Builds/win/export_name.exe (debug|release) (find_local_version|vX.X.X)\n"
  exit 1
fi

if [ "$LOCAL_VERSION" = "find_local_version" ]; then
  # quick and dirty way to update the version number, not corresponding with other platform builds
  LATEST_TAG=$(git describe --tags --abbrev=0)
  COMMITS=$(git rev-list --count HEAD)
  VERSION="$LATEST_TAG.$COMMITS"
  printf "Using calculated local version: $VERSION\n"
else
  VERSION="$LOCAL_VERSION"
  printf "Using provided local version: $VERSION\n"
fi
sed -i '' 's/config\/version=".*"/config\/version="'"$VERSION"'"/' project.godot

# strip the output path from output file
EXPORT_PATH=$(dirname $OUTPUT_FILE)

printf "Building for platform: $PLATFORM\n"
printf "Output file: $OUTPUT_FILE\n"
printf "Export path: $EXPORT_PATH\n"
printf "Build mode: $BUILD_MODE\n"

BUILD_MODE_FLAG="--export-debug"
if [[ "$BUILD_MODE" == "release" ]]; then
  BUILD_MODE_FLAG="--export-release"
fi

rm -rf $EXPORT_PATH
mkdir -p $EXPORT_PATH
godot --verbose "$BUILD_MODE_FLAG" --headless "$PLATFORM" $OUTPUT_FILE 