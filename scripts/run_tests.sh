#!/usr/bin/env bash

GUT_OUTPUT=$(godot --headless --path . -s addons/gut/gut_cmdln.gd -gexit 2>&1 | tee /dev/stderr)

if [[ $GUT_OUTPUT == *"because it does not extend GutTest"* ]]; then
  echo -e "\e[31ma) Not all test files were executed. Tests failed! 😭\e[0m"
  exit 1
elif [[ $GUT_OUTPUT == *"SCRIPT ERROR"* ]]; then
  echo -e "\e[31mb) Some script errors occurred. Tests failed! 😭\e[0m"
  exit 1
elif [[ $GUT_OUTPUT != *"All tests passed"* ]]; then
  echo -e "\e[31mc) Not all tests passed. Tests failed! 😭\e[0m"
  exit 1
else
  echo -e "\e[32mTests passed! ✅\e[0m"
  exit 0
fi