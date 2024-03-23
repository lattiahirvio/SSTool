#!/bin/bash

# Find the Java process related to Minecraft
ProcessCheck=$(ps -ef | grep 'java' | grep 'minecraft' | sort -g | awk '{print $2}')

# Check if the process is running
if [[ -n $ProcessCheck ]]; then
    # Check if a deleted file is mapped by the process
    if grep -q 'deleted' /proc/$ProcessCheck/task/$ProcessCheck/maps; then
        echo "User associated with Minecraft has a deleted file mapped in memory" >> output/results.txt
    fi
fi
