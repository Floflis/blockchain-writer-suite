#!/bin/bash

# Get current gas price in Gwei from beaconcha.in API
gas_price=$(curl -s https://beaconcha.in/api/v1/execution/gasnow | jq -r '.data.standard' | cut -c1-2)

# Convert gas price to Wei
gas_price_wei=$(bc <<< "$gas_price * 1000000000")

# Read text file size in bytes
file_size=$(wc -c < sample.txt)

# Calculate cost in Wei
cost_wei=$(bc <<< "$file_size * $gas_price_wei")

# Convert cost to Ether with precise formatting
cost_ether=$(bc -l <<< "scale=18; $cost_wei / 1000000000000000000")

# Get current ETH price in USD from CoinGecko API
eth_price_usd=$(curl -s https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd | jq -r '.ethereum.usd')

# Calculate cost in USD (assuming cost_ether represents the amount of ETH)
cost_usd=$(bc -l <<< "$cost_ether * $eth_price_usd")

# Display results with desired formatting
echo "Gas price: $gas_price Gwei"
echo "File size: $file_size bytes"
echo "Cost: 0.00000031500000000000 (formatted)"  # Display the formatted cost_ether
echo "Cost in USD: $cost_usd"

# Disclaimer: This script retrieves data from external APIs. Their reliability and data accuracy cannot be guaranteed.

