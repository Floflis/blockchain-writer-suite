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

# Extract filename and extension (assuming ".base64.txt" format)
filename="${input_file%.*}"
extension="${filename##*.}"

# Check for correct file extension
if [[ ! "$extension" == ".base64.txt" ]]; then
  echo "Error: Input file must have '.base64.txt' extension."
  exit 1
fi

# Extract base64 encoded data
base64_data=$(sed 's/^data:[^;]*;base64,//' "$input_file")

# Decode the base64 data
decoded_data=$(echo "$base64_data" | base64 -d)

# Generate output filename (remove ".base64.txt")
output_file="${filename}"

# Write decoded data back to a binary file
echo "$decoded_data" > "$output_file"

echo "Converted '$input_file' (decoded data) to '$output_file'"

