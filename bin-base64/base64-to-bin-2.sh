#!/bin/bash

# Check for required argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

# Get input filename
input_file="$1"

# Check if file exists
if [ ! -f "$input_file" ]; then
  echo "Error: File '$input_file' does not exist."
  exit 1
fi

# Extract filename with extension
filename="${input_file}"

# **Handle potential null bytes:**
base64_data=$(sed 's/^data:[^;]*;base64,//' "$input_file" | tr -d '\0')

# Decode the base64 data (assuming no null bytes present)
decoded_data=$(echo "$base64_data" | base64 -d)

# Write decoded data back to a binary file
echo "$decoded_data" > "$filename"

echo "Converted '$input_file' (decoded data) to '$filename'"

# **Warning:** This script attempts to remove null bytes, but it's a basic approach. Consider using established tools for robust error handling.

