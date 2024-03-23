#!/bin/bash

# Check if wineserver is running
if pgrep -x wineserver >/dev/null; then
    # Check if Java.exe (Minecraft under Wine) is running
    if pgrep -x java.exe >/dev/null; then
        # Capture information about the Java process
        mcproc=$(ps aux | grep java.exe)
        # Append information to a temporary file
        echo "$mcproc" >> /tmp/WineScan.tmp
        # Wait for 1 second to ensure proper capture
        sleep 1
        # Log failure of Wine test
        echo "User Failed Wine Test" >> output/results.txt
        # Check if Java process has javaagent
        if grep -q "javaagent" /tmp/WineScan.tmp; then
            echo "User Failed Wine Java Agent Test" >> output/results.txt
        fi
    else
        # Inform that Minecraft is not running under Wine and exit
        echo "Minecraft is not running under Wine." >> output/results.txt
        exit
    fi
fi

# Clean up temporary files
rm -f /tmp/WineScan*.tmp

