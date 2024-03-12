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

# Get file extension (lowercase)
extension="${input_file##*.}"
extension=$(tr '[A-Z]' '[a-z]' <<< "$extension")

# Determine MIME type based on extension (basic check)
mime_type="unknown"
case "$extension" in
  "jpg"|"jpeg") mime_type="image/jpeg" ;;
  "png") mime_type="image/png" ;;
  "gif") mime_type="image/gif" ;;
  "opus") mime_type="audio/opus" ;;
  # Add more mime types as needed
  *) ;;
esac

# Base64 encode the file content (assuming no null bytes present)
base64_data=$(base64 -w 0 "$input_file")

# Construct Data URI
data_uri="data:$mime_type;base64,$base64_data"

# Generate output filename
output_file="${input_file%.*}.base64.txt"

# Save Data URI to file
echo "$data_uri" > "$output_file"

echo "Converted '$input_file' to '$output_file'"

# **Disclaimer:** This script assumes the absence of null bytes in the input file. Consider using established libraries for robust data handling.

