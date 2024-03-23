#!/bin/bash

# Get the current username
CurrentUser=$SUDO_USER

# Check if Bash history file exists
if [ -f "/home/$SUDO_USER/.bash_history" ]; then
    # Get the modification time of the Bash history file
    ClearHistory=$(stat -c '%Y' "/home/$SUDO_USER/.bash_history")
else
    echo "Bash history file not found for user $SUDO_USER"
    exit 1
fi

# Get the system start time
ComputerStart=$(stat -c '%Y' /dev/null)

# Compare timestamps to detect if history was cleared
if [[ $ClearHistory -gt $ComputerStart ]]; then
    # Log suspicious activity
    echo "User $SUDO_USER has cleared Bash history since system start" >> output/results.txt
fi
