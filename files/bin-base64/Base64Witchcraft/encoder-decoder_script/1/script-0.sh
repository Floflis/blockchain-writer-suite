#!/bin/bash

# Encode the original file to Base64
base64 originalfile.txt > encodedfile.txt

# Generate hash of the original file
sha256sum originalfile.txt > originalfile.txt.sha256

# Decode the Base64 file back to its original form
base64 -d encodedfile.txt > decodedfile.txt

# Generate hash of the decoded file
sha256sum decodedfile.txt > decodedfile.txt.sha256

# Compare the hashes
if diff originalfile.txt.sha256 decodedfile.txt.sha256 > /dev/null; then
    echo "Hashes match! The decoded file is identical to the original file."
else
    echo "Hashes do not match! There is an error in the process."
fi

