#!/bin/bash

# Set directory containing split files
split_dir="split"

# Check if the split directory exists
if [ ! -d "$split_dir" ]; then
  echo "Error: Split directory '$split_dir' does not exist."
  exit 1
fi

# Get all files in the split directory sorted by name (numerical order)
files=("$split_dir"/*)
sorted_files=($(ls -vn "$split_dir"))

# Function to join split files
join_files() {
  local target_file="$1"
  
  # Check if target file already exists
  if [ -f "$target_file" ]; then
    echo "Warning: File '$target_file' already exists. Using '${target_file}.joint' instead."
    target_file="$target_file.joint"
  fi
  
  touch "$target_file"
  
  for filename in "${sorted_files[@]}"; do
    cat "$split_dir/$filename" >> "$target_file"
  done
  
  echo "Joined files into '$target_file'."
}

# Loop through sorted files and join them
for filename in "${sorted_files[@]}"; do
  # Extract base filename without extension
  base="${filename%.*}"
  
  # Join the files into the original filename (or 'joint.svg' if it exists)
  join_files "$base"
done

echo "All files in '${split_dir}' successfully joined."

