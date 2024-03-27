#!/bin/bash

# Check if argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Get the uptime of the system in seconds
uptime_seconds=$(awk '{print int($1)}' /proc/uptime)

# Calculate the time of last reboot
last_reboot=$(date -d "$(uptime -s)" +"%Y-%m-%d %H:%M:%S")

# Execute the command with sudo and append output to results.txt
sudo find "${1}" -path /proc -prune -o -type f -not -name '*.json' -newermt "$last_reboot" -print | xargs sudo stat --format '%Y :%y %n' 2>/dev/null | sort -nr | cut -d: -f2- | grep -E "\.(pdf|jar|exe|deb|AppImage|py|sh|bash|pl|php|rb|js|html|css)$"
