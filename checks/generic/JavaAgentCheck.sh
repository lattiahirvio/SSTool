#!/bin/bash

# Run ps command to get information about Java processes
mcproc=$(pgrep java)

# Redirect the output to a temporary file
echo "$mcproc" > /tmp/NativeAgent.tmp

# Check if the temporary file contains "javaagent"
if grep -q "javaagent" /tmp/NativeAgent.tmp; then
    # If "javaagent" is found, append a message to the results file
    echo "User Failed Native Java Agent Check" >> output/results.txt
    echo "User Failed Native Java Agent Check" 
fi

# Clean up by removing the temporary file
rm /tmp/NativeAgent.tmp
