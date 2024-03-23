#!/bin/bash

DIRECTORY="/home/$SUDO_USER/.local/share/PrismLauncher/"

if [ -d "$DIRECTORY" ]; then
  echo "Directory Checker: The directory $DIRECTORY exists." >> output/results.txt
  echo "Directory Checker: The directory $DIRECTORY exists. The user MIGHT be using PrismLauncher, so check that too!"
fi

