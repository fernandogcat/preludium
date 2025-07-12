#!/usr/bin/env bash

# if called with incorrect number of arguments, print usage
if [ "$#" -lt 6 ]; then
  printf "Need arguments. Usage example: . scripts/build_and_upload_to_itchio.sh osx ./Builds/osx/export_name.app itchio_username itchio_game debug v0.9.0-0\n"
  return
fi

PLATFORM=$1
OUTPUT_FILE=$2
ITCHIO_USERNAME=$3
ITCHIO_GAME=$4
BUILD_MODE=$5
LOCAL_VERSION=$6

# check if git status is not clean, abort
# if [ -n "$(git status --porcelain)" ]; then
#   printf "⛔️⛔️ Git status is not clean, aborting ⛔️⛔️\n"
#   return 1
# fi

# First build the game
. scripts/build_with_godot.sh "$PLATFORM" "$OUTPUT_FILE" "$BUILD_MODE" "$LOCAL_VERSION"

# Check if build was successful
if [ $? -ne 0 ]; then
  printf "⛔️⛔️ Build failed, aborting upload ⛔️⛔️\n"
  return 1
fi

# Then upload to itch.io
. scripts/upload_to_itchio.sh "$PLATFORM" "$OUTPUT_FILE" "$ITCHIO_USERNAME" "$ITCHIO_GAME"