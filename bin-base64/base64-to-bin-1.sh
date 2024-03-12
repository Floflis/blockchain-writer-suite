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

# Extract filename with extension (assuming any valid extension)
filename="${input_file}"

# Write decoded data back to a binary file (assuming correct extension)
base64_data=$(sed 's/^data:[^;]*;base64,//' "$input_file")
decoded_data=$(echo "$base64_data" | base64 -d)
echo "$decoded_data" > "$filename"

echo "Converted '$input_file' (decoded data) to '$filename'"

