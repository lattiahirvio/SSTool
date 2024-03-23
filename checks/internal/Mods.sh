#!/bin/bash

# Clean up previous temporary files
rm -f /tmp/sstool*.tmp
rm -f /tmp/jars.sstool

# Calculate SHA-256 checksums for Minecraft mod files
Sha256Check=$(sha256sum /home/$SUDO_USER/.minecraft/mods/* 2>/dev/null)

# Append checksums to a temporary file
echo "$Sha256Check" >> /tmp/sstool$RANDOM.tmp

# Check for specific checksums indicating cheat usage
if grep -q "376ecfd4a962c65825b60db8bb687d5b911a5d8a4400d8b214dec9b72a755f13" /tmp/sstool*.tmp; then
    echo "User has been caught using Zyklon Web Ghost Client" >> output/results.txt
    echo -e '\e[31mThe User is using Zyklon Ghost Client!\e[0m'
fi

# Extract information from JAR files
cd /home/$SUDO_USER/.minecraft/mods/
for j in *.jar; do 
    unzip -l "$j" >> /tmp/jars.sstool
done
cd -

# Check for specific strings indicating cheat usage in JAR files
if grep -q "Velocity.class\|AntiKnockback.class\|Esp.class\|Reach.class\|Safewalk\|Keepsprint\|AntiBot\|Nametags.class\|Eagle.class\|Spammer.class\|SelfDestruct\|AutoClicker.class\|wtap\|PenisESP\|Syracuse.vip\|meteordevelopment/meteorclient/utils/render/postprocess/postprocessshaders" /tmp/jars.sstool; then
  echo "Failed Generic module check A!" >> output/results.txt
  echo -e '\e[31mFailed Generic module check A!\e[0m'
fi

# Check for specific strings indicating cheat usage in JAR files
if grep -q "your hwid:\|players hitbox\|org.apache.core.m.ms.r.nhc\|modules/combat/" /tmp/jars.sstool; then
  echo "Failed Generic module check B!" >> output/results.txt
  echo -e '\e[31mFailed Generic module check B!\e[0m'
fi

if grep -q "ucoz\|gRYVNDkJr03nW7iDJP6gXnNM3mex+IF3i+YUCozyWEs=\|yoKXth8DfBuCOZGvc+OIWUebiXuVtoJEPrFaoKA8HrY=" /tmp/jars.sstool; then
  echo "The user is using DOOMSDAY Client!" >> output/results.txt
  echo -e '\e[31mThe User is using DOOMSDAY Client!\e[0m'
fi

# Check for the presence of JNativeHook
if [ -f /tmp/libJNativeHook*.so ]; then
    echo "User Failed JNativeHook Check" >> output/results.txt
    echo -e '\e[31mFailed JNativeHook Check!\e[0m'
fi

# Clean up temporary files
rm -f /tmp/sstool*.tmp
rm -f /tmp/jars.sstool
