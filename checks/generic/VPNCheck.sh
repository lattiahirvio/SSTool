
#!/bin/bash

# Get user's public IP address from Amazon
userip=$(curl -s https://checkip.amazonaws.com)

# Remove any existing ipv4.txt file
rm -f ipv4.txt

# Download list of IPv4 addresses associated with VPN services
if curl -sS https://raw.githubusercontent.com/X4BNet/lists_vpn/main/ipv4.txt -o ipv4.txt; then
    echo "VPN IP list downloaded successfully."
else
    echo "Failed to download VPN IP list."
    exit 1
fi

# Check if user's public IP address is found in the downloaded VPN list
if grep -q "$userip" ipv4.txt; then
    echo "User is using a generic VPN (Check C)" >> output/results.txt
    rm -f ipv4.txt
fi

# Check if specific VPN processes are running
if pgrep -x openvpn >/dev/null; then
    echo "User has OpenVPN running (Check C1)" >> output/results.txt
fi

if pgrep -x Windscribe >/dev/null; then
    echo "User has Windscribe VPN running (Check C2)" >> output/results.txt
fi

if pgrep -x riseup-vpn >/dev/null; then
    echo "User has Riseup VPN running (Check C3)" >> output/results.txt
fi

if pgrep -x protonvpn* >/dev/null; then
    echo "User has Proton VPN running (Check C4)" >> output/results.txt
fi

if pgrep -x vyprvpn >/dev/null; then
    echo "User has VyprVPN running (Check C5)" >> output/results.txt
fi

if pgrep -x nordvpn >/dev/null; then
    echo "User has NordVPN running (Check C6)" >> output/results.txt
fi

if pgrep -x MullvadVPN >/dev/null; then
    echo "User has Mullvad VPN running (Check C7)" >> output/results.txt
fi

