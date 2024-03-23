
#!/bin/bash

# Check if argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Execute the command with sudo and append output to results.txt
sudo find "${1}" -type f | xargs sudo stat --format '%Y :%y %n' 2>/dev/null | sort -nr | cut -d: -f2- | grep -E "\.(jar|exe|deb|AppImage|py|sh|bash|pl|php|rb|js|html|css)" >> output/results.txt

