#!/bin/bash

# Function to list the contents of the mods directory and send files to Discord
list_mods_directory() {
  local MODS_DIR="$1"
  local USERNAME="$2"
  local FILE_WEBHOOK_URL="$3"
  
  if [ -d "$MODS_DIR" ]; then
    for FILE in "$MODS_DIR"/*; do
      if [ -f "$FILE" ]; then
        send_file_to_discord "$FILE" "$USERNAME" "$FILE_WEBHOOK_URL" &
        sleep 0.55  # Add a delay to avoid rate limiting (adjust as needed)
      fi
    done
    wait  # Wait for all background processes to finish
  else
    echo "The $MODS_DIR directory does not exist." >> output/results.txt
    echo "The $MODS_DIR directory does not exist." 
  fi
}

# Function to send a file to Discord
send_file_to_discord() {
  local FILE_PATH="$1"
  local USERNAME="$2"
  local FILE_WEBHOOK_URL="$3"
  local JSON=$(jq -n --arg user "$USERNAME" '{"username": $user}')
  local FILE_SIZE=$(stat -c%s "$FILE_PATH")
  
  if (( FILE_SIZE <= 25000000 )); then
    curl -X POST -H "Content-Type: multipart/form-data" -F "file=@$FILE_PATH" -F "payload_json=$JSON" "$FILE_WEBHOOK_URL"
  fi
}

# Parsing command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -d|--directory)
            MODS_DIR="$2"
            shift
            shift
            ;;
        -u|--username)
            USERNAME="$2"
            shift
            shift
            ;;
        -w|--webhook)
            FILE_WEBHOOK_URL="$2"
            shift
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Call the function to list the mods directory and send files to Discord
list_mods_directory "$MODS_DIR" "$USERNAME" "$FILE_WEBHOOK_URL"
