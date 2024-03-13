#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file_path> <eth_address>"
    exit 1
fi

file_path=$1
eth_address=$2

# Read the HEX contents of the file
hex_contents=$(xxd -p $file_path)

# Send the HEX contents to the given ETH address using ethereal
ethereal message --to $eth_address --data $hex_contents

# Unlock the local wallet and sign to send
ethereal account unlock

echo "Message sent successfully to $eth_address"

exit 0
