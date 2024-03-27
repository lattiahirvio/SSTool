#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

# Find the Java process related to Minecraft
ProcessCheck=$(pgrep -f 'java.*minecraft')

# Check if the process is running
if [[ -n $ProcessCheck ]]; then
    # Create a temporary file to store the list of files before script execution
    tmpfile=$(mktemp)
    ls /proc/$ProcessCheck/fd > "$tmpfile"

    # Check if the temporary file exists and is not empty
    if [ -s "$tmpfile" ]; then
        # Check if any files were deleted
        diff=$(diff "$tmpfile" <(ls /proc/$ProcessCheck/fd))
        if [ -n "$diff" ]; then
            echo "User associated with Minecraft has deleted files (Deleted File C)" >> output/results.txt
            echo -e "${RED}User associated with Minecraft has deleted files (Deleted File C) ${NC}"
        fi
    fi

    # Remove temporary file
    rm "$tmpfile" >/dev/null 2>&1
fi

