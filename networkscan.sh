#!/bin/bash

# Check for required argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <subnet>"
    echo "Example: $0 192.168.1"
    exit 1
fi

subnet=$1

# Perform the network scan
echo "Scanning the network, please wait..."
nmap -sP "$subnet.0/24" --open | awk '/Nmap scan report for/ {printf "\n%s - ", $5} /MAC Address:/ {print $3 " (" $4 " " $5 " " $6 ")"}'

# Perform a more detailed scan on each host
echo -e "\nPerforming a more detailed scan on each host...\n"
nmap -O "$subnet.0/24" | grep -E 'Nmap scan report for|MAC Address:|Device type:|Running:|OS details:'

echo -e "\nScan complete."
