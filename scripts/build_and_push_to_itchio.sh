#!/usr/bin/env bash

# if called with incorrect number of arguments, print usage
if [ "$#" -lt 4 ]; then
  printf "Invalid number of arguments: $# provided, 4 minimum required\n. Usage example: scripts/build_and_push_to_itchio.sh win ./Builds/win/export_name.exe itchio_username itchio_game (debug|release) (find_local_version|vX.X.X)\n"
  exit 1
fi

PLATFORM=$1
OUTPUT_FILE=$2
ITCHIO_USERNAME=$3
ITCHIO_GAME=$4
BUILD_MODE=$5
LOCAL_VERSION=$6

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
if [ -z "$PLATFORM" ] || [ -z "$OUTPUT_FILE" ] || [ -z "$ITCHIO_USERNAME" ] || [ -z "$ITCHIO_GAME" ]; then
  printf "Required parameters not provided\n. Usage: ./build_and_push_to_itchio.sh win ./Builds/win/export_name.exe itchio_username itchio_game (debug|release) (find_local_version|vX.X.X)\n"
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

# printf "Building for platform: $PLATFORM\n"
# printf "Output file: $OUTPUT_FILE\n"
# printf "Export path: $EXPORT_PATH\n"
# printf "Itch.io username: $ITCHIO_USERNAME\n"
# printf "Itch.io game: $ITCHIO_GAME\n"
# printf "Build mode: $BUILD_MODE\n"

BUILD_MODE_FLAG="--export-debug"
if [[ "$BUILD_MODE" == "release" ]]; then
  BUILD_MODE_FLAG="--export-release"
fi

rm -rf $EXPORT_PATH
mkdir -p $EXPORT_PATH
godot --verbose "$BUILD_MODE_FLAG" --headless "$PLATFORM" $OUTPUT_FILE
butler push $EXPORT_PATH $ITCHIO_USERNAME/$ITCHIO_GAME:$PLATFORM