#!/bin/bash

# Clean up existing temporary files, if they exist
sudo rm -f /tmp/MCDUMP*.tmp
sudo rm -f /tmp/DMP*.tmp
rm -f /tmp/javaStrings.tmp

# Get PID of the Java process
mc=$(pgrep java)

# Generate memory map and extract relevant information
pmap -p --show-path "$mc" >> "/tmp/MCDUMP$RANDOM.tmp"

# Extract specific columns from memory dump
cut -c 32-128 /tmp/MCDUMP*.tmp >> /tmp/DMP2.tmp

# Add empty lines for formatting in results file
for ((i=0; i<12; i++)); do
    echo >> output/results.txt
done

# Add separator and header to results file
echo "____________________________________________________________" >> output/results.txt
echo "Memory Dump" >> output/results.txt

# Filter out lines containing spaces
grep -v "[ ]" /tmp/DMP2.tmp >> /tmp/DMP3.tmp


#Extract strings from memory addresses
while read -r line; do
    # Check if the file exists before attempting to read from it
    if [ -e "$line" ]; then
        strings "$line" >> /tmp/javaStrings.tmp &
        sleep 0.01
    fi
done < /tmp/DMP3.tmp

# Check for specific patterns indicating suspicious activity
if grep -q "libphantom.so\|_ZN5ReachC1EP7Phantom\|_ZN9MinecraftC1EP7Phantom" /tmp/DMP2.tmp || grep -q "libphantom.so\|_ZN5ReachC1EP7Phantom\|_ZN9MinecraftC1EP7Phantom\|Rokkit" /tmp/javaStrings.tmp; then
    echo "User was found using Phantom Ghost Client (Check D)" >> output/results.txt
else
    echo "No Injection clients detected." >> output/results.txt
fi

# Clean up temporary files
sudo -E rm -f /tmp/MCDUMP*.tmp
sudo -E rm -f /tmp/DMP*.tmp
rm -f /tmp/javaStrings.tmp
