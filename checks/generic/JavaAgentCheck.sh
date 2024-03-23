#!/bin/bash

# Run ps command to get information about Java processes
mcproc=$(ps aux | grep java)

# Redirect the output to a temporary file
echo "$mcproc" > /tmp/NativeAgent.tmp

# Check if the temporary file contains "javaagent"
if grep -q "javaagent" /tmp/NativeAgent.tmp; then
    # If "javaagent" is found, append a message to the results file
    sudo echo "User Failed Native Java Agent Test" >> output/results.txt
fi

# Clean up by removing the temporary file
rm /tmp/NativeAgent.tmp
