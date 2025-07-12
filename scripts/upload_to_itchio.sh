#!/usr/bin/env bash

# Usage:
# > . scripts/upload_to_itchio.sh osx ./Builds/osx/export_name.app itchio_username itchio_game

# if called with incorrect number of arguments, print usage
if [ "$#" -lt 4 ]; then
  printf "Need arguments. Usage example: . scripts/upload_to_itchio.sh osx ./Builds/osx/export_name.app itchio_username itchio_game\n"
  return
fi

PLATFORM=$1
OUTPUT_FILE=$2
ITCHIO_USERNAME=$3
ITCHIO_GAME=$4

# check for required parameters
if [ -z "$PLATFORM" ] || [ -z "$OUTPUT_FILE" ] || [ -z "$ITCHIO_USERNAME" ] || [ -z "$ITCHIO_GAME" ]; then
  printf "Required parameters not provided\n. Usage: ./upload_to_itchio.sh win ./Builds/win/export_name.exe itchio_username itchio_game\n"
  exit 1
fi

# strip the output path from output file
EXPORT_PATH=$(dirname $OUTPUT_FILE)

printf "Uploading to itch.io:\n"
printf "Platform: $PLATFORM\n"
printf "Export path: $EXPORT_PATH\n"
printf "Itch.io username: $ITCHIO_USERNAME\n"
printf "Itch.io game: $ITCHIO_GAME\n"

butler push $EXPORT_PATH $ITCHIO_USERNAME/$ITCHIO_GAME:$PLATFORM 