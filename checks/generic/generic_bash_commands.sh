#!/bin/bash

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

# Function to send the command output to the results file with formatting
send_command_output() {
  local COMMAND="$1"
  local OUTPUT_FILE="output/results.txt"

  # Execute the command, format the output, and append it to the results file
  {
    echo "Command: $COMMAND"
    echo "Result:"
    $COMMAND
    echo ""
  } >> "$OUTPUT_FILE" 2>&1
}


echo "Running commands..." >> output/results.txt

# Run the commands and send the results to the output file
send_command_output "ps -p $JAVA_PID -o lstart,etime,cmd"
send_command_output "stat $(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)/mods"
send_command_output "who -H"
send_command_output "cat /etc/os-release"
send_command_output "history 100"
send_command_output "ls /home/$SUDO_USER/.local/share/Trash/info/"
send_command_output "journalctl -q | grep disconnect | grep usb"
send_command_output "cat /etc/hosts"
send_command_output "nmcli con show --active | grep -i vpn"
send_command_output "nordvpn status"
send_command_output "cat $(ls -l /proc/$(pgrep java)/fd 2>/dev/null | grep -o '/.*\.minecraft' | head -n 1)/usercache.json | jq '.[] | {name}'"
send_command_output "echo $XDG_CURRENT_DESKTOP"
send_command_output "sudo -E less /var/log/syslog"
send_command_output "lsblk"
send_command_output "ls /tmp/"
send_command_output "find . -mtime -1 -type f"
send_command_output "ps -p $JAVA_PID -o args"
send_command_output "sudo lsof -i"


echo "=========================================================================================================" >> output/results.txt
echo " " >> output/results.txt

