#!/bin/bash

NC='\033[0m' # No Color
RED='\033[0;31m'

# Parsing command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -p|--pid)
            JAVA_PID="$2"
            shift
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Check if Java PID is provided
if [ -z "$JAVA_PID" ]; then
    echo "Error: Java PID not provided."
    exit 1
fi

# Check if the process is running
if ! ps -p $JAVA_PID > /dev/null; then
    echo "Minecraft Java process with PID $JAVA_PID is not running." >> output/results.txt
    exit 1
fi

# Check if the mods folder was modified after the Minecraft game was launched
check_mods_directory() {
    local MINECRAFT_START_TIME
    MINECRAFT_START_TIME=$(get_process_start_time "$JAVA_PID")

    local MinecraftPath
    MinecraftPath=$(find /proc/$JAVA_PID/fd -type l -printf "%l\n" 2>/dev/null | grep -m 1 '\.minecraft')

    # Extract only the directory path up to ".minecraft"
    MinecraftPath=${MinecraftPath%%/.minecraft*}

    # Append ".minecraft/mods" to the extracted path
    local ModsPath="$MinecraftPath/.minecraft/mods"

    # Check if MinecraftPath is empty
    if [ -z "$ModsPath" ]; then
        echo "Mods directory not found."
        exit 1
    fi

    local MODS_MODIFICATION_TIME
    MODS_MODIFICATION_TIME=$(stat -c %Y "$ModsPath")

    if [ "$MODS_MODIFICATION_TIME" -gt "$MINECRAFT_START_TIME" ]; then
        echo "The mods folder was modified after the Minecraft game was launched." >> output/results.txt
        echo "Ban the user." >> output/results.txt
        echo -e "${RED}The mods folder was modified after the Minecraft game was launched."
        echo -e "Ban the user.${NC}"
        exit 1
    else
        echo "The mods folder was not modified after the Minecraft game was launched." >> output/results.txt
    fi
}

# Function to get the start time of a process by PID as a Unix timestamp
get_process_start_time() {
    local PID="$1"
    local START_TIME
    START_TIME=$(ps -p "$PID" -o lstart=)
    START_TIME=$(date -d "$START_TIME" +"%s")
    echo "$START_TIME"
}

# Call the function to check the mods directory
check_mods_directory
