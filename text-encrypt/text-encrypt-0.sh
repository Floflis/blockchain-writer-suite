#!/bin/bash

# Check for required arguments
if [ $# -lt 3 ]; then
  echo "Usage: $0 <secret> <input_file> <output_file>"
  exit 1
fi

# Get secret, input file, and output filename
secret="$1"
input_file="$2"
output_file="${2%.txt}.encrypted.txt"  # Append ".encrypted.txt"

# Check if input file exists
if [ ! -f "$input_file" ]; then
  echo "Error: File '$input_file' does not exist."
  exit 1
fi

# **Warning:** Using AES-128-ECB is not recommended for secure encryption.

# Encrypt the file with AES-128-ECB (not recommended for secure use)
openssl enc -aes-128-ecb -e -in "$input_file" -out "$output_file" -k "$secret" -pass pass:

# Informative message
echo "**WARNING:** This script uses AES-128-ECB, which is a weak encryption mode. Consider using established libraries or tools for secure file encryption."

echo "Encrypted file: $output_file"

