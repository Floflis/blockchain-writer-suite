#!/bin/bash

# Check for required argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <file_list>"
  exit 1
fi

# Get the file list
file_list="$1"

# Check if file list exists
if [ ! -f "$file_list" ]; then
  echo "Error: File list '$file_list' does not exist."
  exit 1
fi

# Output filename (timestamped)
output_file="serialized_data_$(date +%Y-%m-%d_%H-%M-%S).txt"

# Loop through each file in the list
while IFS= read -r filename; do
  # Check if file exists
  if [ ! -f "$filename" ]; then
    echo "Warning: File '$filename' does not exist. Skipping..."
    continue
  fi

  # Get full path (if only filename provided)
  if [[ ! "$filename" == /* ]]; then
    filename="$PWD/$filename"
  fi

  # Read file content
  content=$(cat "$filename")

  # Separator for each file entry
  separator="-----------------------------------------------------------------------------------------------------------"

  # Write file information to output
  echo "$separator" >> "$output_file"
  echo ">$filename" >> "$output_file"
  echo "$content" >> "$output_file"
  echo "<---- $filename" >> "$output_file"
  echo "$separator" >> "$output_file"
done < "$file_list"

echo "Serialized file content to: $output_file"

