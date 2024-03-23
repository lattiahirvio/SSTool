#!/bin/bash

# Check if systemd-resolved is active
if ! systemctl is-active --quiet systemd-resolved; then
    echo "systemd-resolved is not active." >> output/results.txt
    exit 1
fi

# Execute the command with error handling
sudo killall -USR1 systemd-resolved & sudo journalctl -u systemd-resolved >> output/results.txt 2>&1

# Check if the command executed successfully
if [ $? -ne 0 ]; then
    echo "Failed to execute the command." >> output/results.txt
fi
