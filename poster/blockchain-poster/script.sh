#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <msg_file-path> <eth_address> --network <evm_network>"
    exit 1
fi

if [ "$3" = "--network" ]; then
    if [ "$4" = "polygon" ]; then
       choosen_network="https://polygon-mainnet.public.blastapi.io"
       network_chainid="137"
       network_gas_standard="$(curl -s 'https://gasstation.polygon.technology/v2' | jq -r '.standard.maxPriorityFee')"
    fi
    if [ "$4" = "polygonzkevm" ]; then
       choosen_network="https://rpc.ankr.com/polygon_zkevm"
       network_chainid="1101"
       network_gas_standard="$(curl -s 'https://gasstation.polygon.technology/zkevm' | jq -r '.standard')"
    fi
    if [ "$4" = "arbitrum" ]; then
       choosen_network="https://arbitrum-one.public.blastapi.io"
       network_chainid="42161"
       network_gas_standard="0.1"
    fi
    if [ "$4" = "optimism" ]; then
       choosen_network="https://rpc.ankr.com/optimism"
       network_chainid="10"
       network_gas_standard="0.1"
    fi
    if [ "$4" = "base" ]; then
       choosen_network="https://base.llamarpc.com"
       network_chainid="8453"
       network_gas_standard="0.1"
    fi
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
tx_id=$(ethereal --connection="$choosen_network" --chainid="$network_chainid" transaction send --from=$USER_ADDRESS --to=$destination_address --amount="0" --data "$plain_contents" --priority-fee-per-gas "$network_gas_standard Gwei" --debug --wait)
#-
rm output.txt

# Store the transaction ID in a JSON file
echo "[DEBUG] tx_id: $tx_id"
echo "{\"transaction_id\": \"$tx_id\"}" | jq '.' > transaction_id.json

## Unlock the local wallet and sign to send
#ethereal account unlock

echo "Message (probably) sent successfully to $destination_address! (You may) Find details in transaction_id.json"

exit 0
