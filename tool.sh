#!/bin/bash

# Defining common variables.
WEBHOOK_URL=""
FILE_WEBHOOK_URL=""
JAVA_PID=$(pidof java)
Version="1.0.0"

# ANSI escape color codes...
NC='\033[0m' # No Color

# Regular colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Parsing command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -w|--webhook)
            WEBHOOK_URL="$2"
            FILE_WEBHOOK_URL="$WEBHOOK_URL"
            DESTINATION="discord"
            shift
            shift
            ;;
        -f|--fileio)
            DESTINATION="fileio"
            shift
            ;;
        -fw|--file-webhook)
            FILE_WEBHOOK_URL="$2"
            shift
            shift
            ;;
        -u|--sudo-user) 
            SUDO_USER="$2"
            shift
            shift
            ;;
        *)
            shift
            ;;
    esac
done

export SUDO_USER=$SUDO_USER

AsciiArt="
${CYAN} __          ___       _______   ______     ______   .__   __.         
|  |        /   \     /  _____| /  __  \   /  __  \  |  \ |  |         
|  |       /  ^  \   |  |  __  |  |  |  | |  |  |  | |   \|  |  ______ 
|  |      /  /_\  \  |  | |_ | |  |  |  | |  |  |  | |  .    | |______|
|  \----./  _____  \ |  |__| | |  \--/  | |  \--/  | |  |\   |         
|_______/__/     \__\ \______|  \______/   \______/  |__| \__|         
                                                                       
${GREEN}     _______.     _______.___________.  ______     ______    __        
    /       |    /       |           | /  __  \   /  __  \  |  |       
   |   (----/   |   (----\---|  |----/|  |  |  | |  |  |  | |  |       
    \   \        \   \       |  |     |  |  |  | |  |  |  | |  |       
.----)   |   .----)   |      |  |     |  \--/  | |  \--/  | |  \----.  
|_______/    |_______/       |__|      \______/   \______/  |_______| ${NC}
"

Info="Version: $Version       Author: ${PURPLE}lagoon${NC}         User: $SUDO_USER"

clear
echo -e "$AsciiArt"
echo -e "$Info"
mkdir output

getModsModificationTime() {
  local modsDirectory="$(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)"
  local modsModificationTime
  modsModificationTime=$(stat -c %y "$modsDirectory")
  modsModificationTime=$(date -d "$modsModificationTime" +"%s")
  echo "$modsModificationTime"
}

getProcessStartTime() {
  local pid="$1"
  local startTime
  startTime=$(ps -p "$pid" -o lstart=)
  startTime=$(date -d "$startTime" +"%s")
  echo "$startTime"
}

runScripts() {
    # Send shit to Discord
    if [ "$DESTINATION" == "discord" ]; then
        if [ -n "$WEBHOOK_URL" ]; then
            echo "Sending mods to a webhook..."
            bash checks/internal/Mods2.sh -d "$(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)/mods" -u "ModChecker" -w "$FILE_WEBHOOK_URL" >& /dev/null
            echo "Sending Trash files to a webhook..."
            #bash checks/generic/TrashCheck.sh -w "$FILE_WEBHOOK_URL" >& /dev/null
        fi
    fi
  
    # Run each check
    echo "Running Checks for Recently Launched Programs."
    bash checks/generic/RecentPrograms.sh

    echo "Running checks for recently modified files."
    sudo -E checks/generic/ModifiedFilesA.sh /

    echo "Running DNSCache checks"
    bash checks/generic/DNScache.sh

    echo "Running DeletedFileA"
    #bash checks/generic/DeletedFileA.sh

    echo "Running DeletedFileB"
    bash checks/generic/DeletedFileB.sh -p $JAVA_PID

    echo "Running Minecraft folder modification checks"
    bash checks/generic/MinecraftFolderCheck.sh

    echo "Running Bash History checks"
    bash checks/generic/HistoryCheck.sh

    echo "Running Generic bash Command checks"
    bash checks/generic/generic_bash_commands.sh -p $JAVA_PID

    echo "Running Injection checks"
    bash checks/generic/InjCheck.sh

    echo "Running Wraith check"
    bash checks/internal/WraithDetection.sh

    echo "Running Java Agent checks"
    bash checks/generic/JavaAgentCheck.sh

    echo "Running WinE checks"
    bash checks/generic/WinECheck.sh

    echo "Running VirtualMachine checks"
    bash checks/generic/VMCheck.sh

    echo "Running VPN Checks"
    bash checks/generic/VPNCheck.sh

    echo "Checking if the user is using PrismLauncher."
    bash checks/internal/PrismLauncherCheck.sh

    echo "Checking the user's mods..."
    bash checks/internal/Mods.sh
    #bash checks/internal/Mods2.sh

    clear
    echo -e "$AsciiArt"
    echo -e "$Info"
}

runScripts

# Send results to either Discord or fileio

# Function to send a file to Discord
send_file_to_discord() {
  local FILE_PATH="$1"
  local USERNAME="$2"
  local JSON=$(jq -n --arg user "$USERNAME" '{"username": $user}')
  local FILE_SIZE=$(stat -c%s "$FILE_PATH")
  
  if (( FILE_SIZE <= 8000000 )); then
    curl -X POST -H "Content-Type: multipart/form-data" -F "file=@$FILE_PATH" -F "payload_json=$JSON" "$FILE_WEBHOOK_URL"
  fi
}

# Define the URL
URL='https://file.io/'

# Upload function
upload_to_file_io() {
    local file_path="$1"
    local response=$(curl -s -F "file=@$file_path" $URL)
    local link=$(echo $response | jq -r '.link')
    echo $link
}

# Check if destination is Discord or file.io
if [ "$DESTINATION" == "discord" ]; then
  send_file_to_discord "output/results.txt" "Files" >& /dev/null
  echo "Sent results to Webhook."
elif [ "$DESTINATION" == "fileio" ]; then
  echo "Hello! It seems you've opted to use file.io, rather than Discord webhooks. Unfortunate, as this disables some checks"
  echo "Even with file.io, you'll get enough information to know if a user is cheating."
  echo "Thanks for choosing the Lagoon-SSTool!"
else
    echo "Invalid destination. Choose 'discord' or 'fileio'."
fi


if [ "$DESTINATION" == "discord" ]; then
  echo "Finalizing... This might take a while."
  sudo rm -f output/results.txt
  echo "Checking Strings..."
  sudo -E checks/internal/StringCheck.sh $JAVA_PID
  sudo -E python3 checks/internal/StringCheck.py $JAVA_PID strings/javaw-detection.txt
  send_file_to_discord "output/results.txt" "Files" >& /dev/null
  echo -e "${RED}Scan finished!${NC}"
else
  echo "Dumping the the Minecraft Process..."
  sudo external-tools/lsdumper $JAVA_PID >> output/dumpJ.txt
  echo "Finalizing... This might take a while."
  echo "Checking Strings..."
  sudo -E checks/internal/StringCheck.sh $JAVA_PID
  sudo -E python3 checks/internal/StringCheck.py $JAVA_PID strings/javaw-detection.txt

  echo "The First link that is the flags and other general info on the user's system"
  echo "The 2nd link is the memory dump we just created."
  python external-tools/LinkGen.py
fi

rm -rf output/*
rm -f mc.txt
# clear
