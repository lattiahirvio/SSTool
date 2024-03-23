#!/bin/bash

# ANSI escape code for red text
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get elapsed time since Minecraft process started
check1=$(ps -p $(pidof java) -o etimes=)

# Initialize check2 and check3 to default values
check2="ERROR: Mods folder not found"
check3="ERROR: Subdirectories in mods folder not found"

# Calculate last modification time of main mods folder
mods_last_modified=$(find /home/$SUDO_USER/.minecraft/mods/* -maxdepth 0 -exec stat -c %Y {} + 2>/dev/null)
if [ -n "$mods_last_modified" ]; then
    check2=$(( $(date +%s) - $mods_last_modified ))
fi

# Calculate last modification time of subdirectories in mods folder
subdirs_last_modified=$(find /home/$SUDO_USER/.minecraft/mods/*/* -maxdepth 0 -exec stat -c %Y {} + 2>/dev/null)
if [ -n "$subdirs_last_modified" ]; then
    check3=$(( $(date +%s) - $subdirs_last_modified ))
fi

# Write results to output file
if [ "$check2" == "ERROR: Mods folder not found" ]; then
    echo "The Error May be due to the user not having an existing mods folder, check if the user is some other client other than Vanilla" >> output/results.txt
    echo -e "${RED}The Error May be due to the user not having an existing mods folder, check if the user is some other client other than Vanilla${NC}"
fi

if [ "$check1" -gt 0 ] && [ "$check1" -gt "$check2" ]; then
    echo "User Modified Mods Folder After Minecraft was launched (Generic 4)" >> output/results.txt
    echo -e "${RED}User Modified Mods Folder After Minecraft was launched (Generic 4)${NC}"
else
    echo "Minecraft was launched $check1 seconds ago & user's mods folder was last modified $check2 seconds ago" >> output/results.txt
    echo -e "Minecraft was launched ${RED}$check1 seconds${NC} ago & user's mods folder was last modified ${RED}$check2 seconds${NC} ago"
fi

if [ "$check1" -gt 0 ] && [ "$check1" -gt "$check3" ]; then
    echo "User Modified Subdirectories in Mods Folder After Minecraft was launched (Generic 4A)" >> output/results.txt
    echo -e "${RED}User Modified Subdirectories in Mods Folder After Minecraft was launched (Generic 4A)${NC}"
else
    echo "Minecraft was launched $check1 seconds ago & user's subdirectories in mods folder were last modified $check3 seconds ago" >> output/results.txt
    echo -e "Minecraft was launched ${RED}$check1 seconds${NC} ago & user's subdirectories in mods folder were last modified ${RED}$check3 seconds${NC} ago"
fi

