#!/bin/bash

input_file=$1

mime_type=$(file --mime-type -b ${input_file})

encoded_file="$1.base64.txt"
decoded_file="$1.base64.decoded.${mime_type#*/}"

# Function to encode a file with MIME type URI prefix
encode_with_uri() {
    input_file=$1
    output_file=$2

    # Generate the Base64 output with URI prefix
#    echo -n "data:@${mime_type};base64," > ${output_file}
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

# Encode the file
if [ "$2" = "--encode" ]; then
    encode_with_uri ${input_file} ${encoded_file}
fi

# Decode the file
if [ "$2" = "--decode" ]; then
    decode_with_uri ${encoded_file} ${decoded_file}
fi

