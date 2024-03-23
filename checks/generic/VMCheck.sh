#!/bin/bash

# Clean up previous temporary files
rm -f /tmp/scanresults.txt

# Check for virtual machine indicators
if cat /etc/hostname | grep -q "VMware"; then
    echo "User has been detected for using a virtual machine 1A" >> ../../output/results.txt
fi

if cat /etc/hostname | grep -q "VM"; then
    echo "User has been detected for using a virtual machine 1B" >> ../../output/results.txt
fi

if cat /etc/hostname | grep -q "virtual"; then
    echo "User has been detected for using a virtual machine 2A" >> ../../output/results.txt
fi

if cat /etc/hostname | grep -q "vbox"; then
    echo "User has been detected for using a virtual machine 2B" >> ../../output/results.txt
fi

if sudo -E lshw -C network | grep -q "VMware"; then
    echo "User has been detected for using a virtual machine 1C" >> ../../output/results.txt
fi

if sudo -E lsmod | grep -q "vmware"; then
    echo "User has been detected for using a virtual machine 1D" >> ../../output/results.txt
fi

if sudo -E ifconfig -a | grep -q "08:00:"; then
    echo "User has been detected for using a virtual machine 4A" >> ../../output/results.txt
fi

if sudo -E ifconfig -a | grep -q "00:05:"; then
    echo "User has been detected for using a virtual machine 3A" >> ../../output/results.txt
fi

if sudo -E ifconfig -a | grep -q "00:0C:"; then
    echo "User has been detected for using a virtual machine 3B" >> ../../output/results.txt
fi

if sudo -E ifconfig -a | grep -q "00:1C:"; then
    echo "User has been detected for using a virtual machine 3C" >> ../../output/results.txt
fi

if sudo -E ifconfig -a | grep -q "00:50:"; then
    echo "User has been detected for using a virtual machine 3D" >> ../../output/results.txt
fi

if sudo -E cat /proc/cpuinfo | grep -q "hypervisor"; then
    echo "User has been detected for using a virtual machine 5A" >> ../../output/results.txt
fi

# Check if dmidecode exists
if ! command -v dmidecode &> /dev/null
then
    echo "dmidecode is not installed or cannot be found. Please install it to proceed." >&2
    exit 1
fi

# Check for virtual machine detection based on dmidecode output
if sudo -E command -v dmidecode &> /dev/null; then
    if sudo -E dmidecode | grep -q 'Microsoft'; then
        echo "User has been detected for using a virtual machine 5B" >> ../../output/results.txt
    fi

    if sudo -E dmidecode | grep -q "VBOX"; then
        echo "User has been detected for using a virtual machine 2C" >> ../../output/results.txt
    fi

    if sudo -E dmidecode | grep -q "06/23/99"; then
        echo "User has been detected for using a virtual machine 2E" >> ../../output/results.txt
    fi
else
  echo "dmidecode not installed on the system!"
fi

if [ -f /proc/xen/privcmd ]; then
    echo "User has been detected for using a virtual machine 6A" >> ../../output/results.txt
elif [ -f /proc/xen/capabilities ]; then 
    echo "User has been detected for using a virtual machine 6B" >> ../../output/results.txt
fi

if cat /proc/cpuinfo | grep -q 'QEMU'; then
    echo "User has been detected for using a virtual machine 6C" >> ../../output/results.txt
fi

if cat /proc/cpuinfo | grep -qi 'amd' && cat /proc/cpuinfo | grep -qvi 'authenticamd'; then
    echo "User has been detected for using a virtual machine 7A" >> ../../output/results.txt
fi

