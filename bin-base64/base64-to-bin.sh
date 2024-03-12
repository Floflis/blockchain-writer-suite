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

# **Informative message:**
echo "WARNING: This script has limitations and might not handle all data corruption issues. Consider using established tools for robust data handling."

# Attempt to remove null bytes (basic approach)
base64_data=$(sed 's/^data:[^;]*;base64,//' "$input_file" | tr -d '\0')

# **Disclaimer:**
echo "**Disclaimer:** Decoding might fail if the data is corrupted beyond simple null bytes."

# Decode the base64 data (assuming no critical corruption)
decoded_data=$(echo "$base64_data" | base64 -d)

# Write decoded data back to a binary file
echo "$decoded_data" > "$filename"

echo "Converted '$input_file' (decoded data) to '$filename'"

