#!/bin/bash

# Set directory containing split files
split_dir="split"

# Check if the split directory exists
if [ ! -d "$split_dir" ]; then
  echo "Error: Split directory '$split_dir' does not exist."
  exit 1
fi

# Get only files with numeric filenames (excluding potential hidden files)
files=("$split_dir/"*[0-9]*)  # Use pattern matching for numeric filenames

# Function to join split files
join_files() {
  local target_file="$1"
  
  # Check if target file already exists
  if [ -f "$target_file" ]; then
    echo "Warning: File '$target_file' already exists. Using '${target_file}.joint' instead."
    target_file="$target_file.joint"
  fi
  
  touch "$target_file"
  
  for filename in "${files[@]}"; do
    # Sort filenames numerically before appending (optional)
    # uncomment the following line if desired:
    # filename=$(echo "$filename" | sort -V)  # Sort using version sort
    cat "$split_dir/$filename" >> "$target_file"
  done
  
  echo "Joined files into '$target_file'."
}

# Loop through files and join them
for filename in "${files[@]}"; do
  # Extract base filename without extension (assuming numeric)
  base="${filename%.*}"
  
  # Join the files into the original filename (or 'joint.svg' if it exists)
  join_files "$base"
done

echo "All valid files in '${split_dir}' successfully joined."

