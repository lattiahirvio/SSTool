#!/bin/bash

# ANSI escape code for red text
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to find Minecraft directory
find_minecraft_directory() {
    local MinecraftPath=$(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)
    [[ -z $MinecraftPath ]] && { echo "ERROR: Minecraft directory not found."; exit 1; }
    echo "$MinecraftPath"
}

# Get Minecraft directory
MinecraftDirectory=$(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)

# Get elapsed time since Minecraft process started
check1=$(ps -p $(pidof java) -o etimes=)

# Check if mods folder exists
if [ ! -d "$(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)/mods" ]; then
    echo "ERROR: Mods folder not found" >&2
    exit 1
fi

# Get the modification time of the mods folder
mods_last_modified=$(stat -c %Y "$(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)/mods")

# Check if there are any files in the mods folder
mods_files=$(find "$(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)/mods" -maxdepth 1 -type f)
if [ -z "$mods_files" ]; then
    echo "No files found in the mods folder" >&2
    exit 1
fi

# Initialize variable to store the maximum file modification time
max_file_mod_time=0

# Iterate over each file in the mods folder and find the maximum modification time
for file in $mods_files; do
    file_mod_time=$(stat -c %Y "$file")
    if [ "$file_mod_time" -gt "$max_file_mod_time" ]; then
        max_file_mod_time=$file_mod_time
    fi
done

# Write results to output file
if [ "$max_file_mod_time" -gt "$mods_last_modified" ] || [ "$max_file_mod_time" -gt "$start_time" ]; then
    echo "User modified files in the mods folder after Minecraft was launched" >> output/results.txt
    echo -e "${RED}User modified files in the mods folder after Minecraft was launched${NC}"
else
    echo "Minecraft was launched $check1 seconds ago & user's mods folder was last modified $mods_last_modified seconds ago" >> output/results.txt
fi

