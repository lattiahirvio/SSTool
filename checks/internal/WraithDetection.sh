#!/bin/bash

searchDir="/"

found_cpp_files=$(grep -rl 'alma::memRead(hotbarStructAddress + activeSlotOffset, 1)[0];' "$searchDir" --include \*.cpp 2>/dev/null)

if [[ -n "$found_cpp_files" ]]; then
    echo "Wraith found, user is cheating" >> output/results.txt
    echo "$found_cpp_files"
fi

alma_lib_path=$(find "$searchDir" -path "*/libs/alma/alma.cpp" 2>/dev/null)

if [[ -n "$alma_lib_path" ]]; then
    echo "Alma found, the user could be using some cheat compiled in cpp" >> output/results.txt
fi
