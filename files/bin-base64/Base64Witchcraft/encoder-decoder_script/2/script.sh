#!/bin/bash

# Function to encode a file with MIME type URI prefix
encode_with_uri() {
    input_file=$1
    output_file=$2

    # Detect MIME type
    mime_type=$(file --mime-type -b ${input_file})

    # Generate the Base64 output with URI prefix
    echo -n "data:@file/${mime_type#*/};base64," > ${output_file}
    base64 ${input_file} >> ${output_file}

    echo "Encoded file with URI prefix:"
    cat ${output_file}
}

# Function to decode a Base64 file, ignoring the URI prefix
decode_with_uri() {
    input_file=$1
    output_file=$2

    # Strip the URI prefix and decode the Base64 content
    base64 -d <(sed 's/^data:@file\/[^,]*,//' ${input_file}) > ${output_file}

    echo "Decoded file created: ${output_file}"
}

# Example usage
input_file="image.jpg"
encoded_file="image_with_uri.base64"
decoded_file="decoded_image.jpg"

# Encode the file
encode_with_uri ${input_file} ${encoded_file}

# Decode the file
decode_with_uri ${encoded_file} ${decoded_file}

