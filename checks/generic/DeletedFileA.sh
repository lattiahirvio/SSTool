#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
# Find the Java process related to Minecraft
ProcessCheck=$(ps -ef | grep 'java' | grep 'minecraft' | sort -g | awk '{print $2}')

# Check if the process is running
if [[ -n $ProcessCheck ]]; then
    # Check if a deleted file is mapped by the process
    if grep -q 'deleted' /proc/$ProcessCheck/task/$ProcessCheck/maps; then
        #echo "User associated with Minecraft has a deleted file mapped in memory" >> output/results.txt
        #echo -e "${RED}User associated with Minecraft has a deleted file mapped in memory${NC}"
    fi
fi
