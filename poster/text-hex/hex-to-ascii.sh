#!/bin/bash

# Check for required arguments
if [ $# -lt 2 ]; then
  echo "Usage: $0 <input_file> <output_file>"
  exit 1
fi

# Get input and output filenames
input_file="$1"
output_file="$2"

# Remove leading "0x" (if present)
sed 's/^0x//' "$input_file" > /tmp/hex_data.tmp

# Use xxd to convert hex data to raw bytes
xxd -r -p < /tmp/hex_data.tmp > "$output_file"

# Clean temporary file
rm /tmp/hex_data.tmp

