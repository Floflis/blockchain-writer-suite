#!/bin/bash

# Check for argument (filename)
if [ $# -ne 1 ]; then
  echo "Usage: file-splitter.sh <filename>"
  exit 1
fi

# Get filename
filename="$1"

# Check file size
file_size=$(wc -c < "$filename")
max_size=89100

if [[ $file_size -lt $max_size ]]; then
  echo "File is smaller than the maximum size (${max_size} bytes). Skipping splitting."
  exit 1
fi

# Create "split" folder if it doesn't exist
split_dir=$(dirname "$filename")/split
mkdir -p "$split_dir"

# Split the file (using a temporary copy)
temp_file="$filename.tmp"
cp "$filename" "$temp_file"  # Create a temporary copy

# Split the temporary file
num_parts=$((file_size / max_size + 1))
remainder=$((file_size % max_size))

with_ext="${filename##*/}"  # Extract filename with extension
base="${with_ext%.*}"       # Extract base name without extension
ext="${with_ext##*.}"       # Extract extension

for i in $(seq 1 $num_parts); do
  part_filename="$split_dir/${base}.split_${i}.$ext"
  if [[ $i -eq $num_parts ]]; then
    head -c $remainder "$temp_file" > "$part_filename"
  else
    head -c $max_size "$temp_file" > "$part_filename"
  fi
done

# Clean up temporary file
rm "$temp_file"

echo "File '${filename}' successfully split into ${num_parts} parts in the '${split_dir}' folder. Original file remains unchanged."

