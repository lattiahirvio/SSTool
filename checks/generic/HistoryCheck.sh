#!/bin/bash

# Get the current username
CurrentUser="$SUDO_USER"

# Check if Bash history file exists
if [ -f "/home/$SUDO_USER/.bash_history" ]; then
    # Check if Bash history file is empty
    if [ ! -s "/home/$SUDO_USER/.bash_history" ]; then
        # Log suspicious activity
        echo "Bash history is empty for user $SUDO_USER" >> output/results.txt
        echo "Bash history is empty for user $SUDO_USER"
    fi
else
    echo "Bash history file not found for user $SUDO_USER"
    exit 1
fi

