#!/bin/bash

# Check for required arguments
if [ $# -lt 2 ]; then
  echo "Usage: $0 <input_file> <output_file>"
  exit 1
fi

# Get input and output filenames
input_file="$1"
output_file="$2"

# Use xxd to convert the file to uppercase hex without spaces
xxd -ps -c 1 -u "$input_file" | tr -d '\n' | sed 's/^/0x/' > "$output_file"

