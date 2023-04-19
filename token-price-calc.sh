#!/bin/bash

# Set gas price in Gwei
gas_price=$(curl -s https://www.gasnow.org/api/v3/gas/price | jq -r '.data.standard')

# Set gas limit
gas_limit=21000

# Read text file size in bytes
file_size=$(wc -c < your_text_file.txt)

# Calculate transaction fee in Wei
tx_fee=$(( $gas_price * $gas_limit * $file_size * 1000000000 ))

# Convert transaction fee to Ether
tx_fee_ether=$(bc -l <<< "scale=8; $tx_fee / 1000000000000000000")

echo "Gas Price: $gas_price Gwei"
echo "Gas Limit: $gas_limit"
echo "File Size: $file_size bytes"
echo "Transaction Fee: $tx_fee Wei"
echo "Transaction Fee (Ether): $tx_fee_ether ETH"

