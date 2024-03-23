#!/bin/bash

# Execute the command and append output to results.txt
ps k-etime h -eo etimes,command | while read etime comm; do
    [ "$etime" -lt 10000 ] && echo -e "$etime\t$comm" >> output/results.txt
done
