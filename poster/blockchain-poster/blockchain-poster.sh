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

# Add this line to read YOUR_ADDRESS from config.json
YOUR_ADDRESS=$(jq -r '.eth' /1/config/user.json)

# Send the HEX contents to the given ETH address using ethereal and capture the transaction ID
## Send the HEX contents to the given ETH address using ethereal
#ethereal transaction send --from=$YOUR_ADDRESS --to=$eth_address --amount="0" --data $hex_contents
tx_id=$(ethereal transaction send --from=$YOUR_ADDRESS --to=$eth_address --amount="0" --data $hex_contents)

# Store the transaction ID in a JSON file
echo "{\"transaction_id\": \"$tx_id\"}" | jq '.' > transaction_id.json

# Unlock the local wallet and sign to send
ethereal account unlock

echo "Message sent successfully to $eth_address"

exit 0
