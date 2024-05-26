#!/bin/bash

# Function to get the MIME type of a file
get_mime_type() {
    file --mime-type -b "$1"
}

# Function to encode a file with MIME type URI prefix
encode_with_uri() {
    input_file=$1
    output_file=$2
    mime_type=$(get_mime_type "${input_file}")

    # Generate the Base64 output with URI prefix
    echo -n "data:${mime_type};base64," > "${output_file}"
    base64 "${input_file}" >> "${output_file}"

    echo "Encoded file with URI prefix:"
    cat "${output_file}"
}

# Function to decode a Base64 file, ignoring the URI prefix
decode_with_uri() {
    input_file=$1
    output_file=$2

    # Extract MIME type and use sed to strip the URI prefix
    mime_type=$(sed -n 's/^data:\([^;]*\);base64,.*/\1/p' "${input_file}")
    
    # Strip the URI prefix and decode the Base64 content
    base64 -d <(sed 's/^data:[^;]*;base64,//' "${input_file}") > "${output_file}.${mime_type#*/}"

    echo "Decoded file created: ${output_file}.${mime_type#*/}"
}

# Encode the file
if [ "$1" = "--encode" ]; then
    encode_with_uri "$2" "$2.base64.txt"
fi

# Decode the file
if [ "$1" = "--decode" ]; then
    decode_with_uri "$2" "$2.base64.decoded"
fi

