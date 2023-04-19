#!/bin/bash

# get current gas price in Gwei from beaconcha.in API
gas_price=$(curl -s https://beaconcha.in/api/v1/execution/gasnow | jq -r '.data.standard' | cut -c1-2) #"cut", from https://stackoverflow.com/a/1405641

# convert gas price to Wei
gas_price_wei=$(bc <<< "$gas_price * 1000000000")

# Read text file size in bytes
#file_size=$(stat -c '%s' <sample.txt)
file_size=$(wc -c < sample.txt)

# calculate cost in Wei
cost_wei=$(bc <<< "$file_size * $gas_price_wei")

# convert cost to Ether
cost_ether=$(bc -l <<< "$cost_wei / 1000000000000000000")

echo "Gas price: $gas_price Gwei"
echo "File size: $file_size bytes"
echo "Cost: $cost_ether Ether"

