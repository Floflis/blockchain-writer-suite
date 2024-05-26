#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file_path> <eth_address>"
    exit 1
fi

file_path=$1
destination_address=$2

# Read the plain contents of the file
make_plain_contents=$(bash /media/daniella/B/git/Floflis/Floflis/Utilities/blockchain-writer-suite/poster/text-hex/ascii-to-hex.sh "$file_path" output.txt)
plain_contents=$(cat output.txt)

# Convert to HEX the contents of the file
#hex_contents=$(bash ascii-to-hex.sh $file_path tmp-content.hex.txt)
#bash ../text-hex/ascii-to-hex.sh $file_path tmp-content.hex.txt

# Add this line to read YOUR_ADDRESS from config.json
USER_ADDRESS=$(jq -r '.eth' /1/config/user.json)

# Send the HEX contents to the given ETH address using ethereal and capture the transaction ID
## Send the HEX contents to the given ETH address using ethereal
#ethereal transaction send --from=$YOUR_ADDRESS --to=$eth_address --amount="0" --data $hex_contents
#tx_id=$(ethereal transaction send --from=$USER_ADDRESS --to=$destination_address --amount="0" --data $plain_contents)
#tx_id=$(ethereal --connection=https://rpc-mainnet.polygonvigil.com/ transaction send --from=$USER_ADDRESS --to=$destination_address --amount="0" --data $plain_contents)
echo "[DEBUG] plain_contents: $plain_contents"
echo "Waiting for your transaction to be mined..."
tx_id=$(ethereal --connection="https://polygon-mainnet.public.blastapi.io" --chainid=137 transaction send --from=$USER_ADDRESS --to=$destination_address --amount="0" --data "$plain_contents" --gaslimit 200 --priority-fee-per-gas "40 Gwei" --debug --wait)
#tx_id=$(ethereal transaction send --from=$YOUR_ADDRESS --to=$eth_address --amount="0" --data tmp-content.hex.txt)
#-
#rm output.txt

# Store the transaction ID in a JSON file
echo "{\"transaction_id\": \"$tx_id\"}" | jq '.' > transaction_id.json

## Unlock the local wallet and sign to send
#ethereal account unlock

echo "Message sent successfully to $destination_address! Find details in transaction_id.json"

exit 0
