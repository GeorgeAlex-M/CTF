#!/bin/bash

# Function to print usage
usage() {
    echo "Usage: $0 <subnet>"
    echo "Example: $0 192.168.4"
}

# Check for the presence of necessary commands
for cmd in ping grep awk; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' not found."
        exit 1
    fi
done

# Check for correct usage
if [ "$#" -ne 1 ]; then
    echo "Error: Invalid number of arguments."
    usage
    exit 1
fi

subnet="$1"

# Simple IP validation
if ! [[ $subnet =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Invalid subnet format."
    usage
    exit 1
fi

# IP Sweep
for ip in $(seq 1 254); do
    ping -c 1 $subnet.$ip | grep "64 bytes" | awk -F ' ' '{ print $4 }' | sed 's/://g' &
done
