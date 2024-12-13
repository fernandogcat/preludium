#!/usr/bin/env bash

GUT_OUTPUT=$(godot --headless --path . -s addons/gut/gut_cmdln.gd -gexit)

echo -e "$GUT_OUTPUT"

# In order to really check if tests were successful, we need to check for the text "All tests passed" 
# because if there are skipped tests, the exit code will be 0 and considered as success
if [[ $GUT_OUTPUT == *"All tests passed"* ]]; then
  echo -e "\e[32mTests passed! ✅\e[0m"
  exit 0
else
  echo -e "\e[31mTests failed! 😭\e[0m"
  exit 1
fi