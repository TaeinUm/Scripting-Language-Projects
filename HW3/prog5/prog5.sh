#!/bin/bash


# Parse Command-Line Arguments
if [ "$#" -ne 2 ]; then
    echo "Input file and dictionary missing."
    exit 1
fi

text_file="$1"
dict_file="$2"


# Validate files
if [ ! -f "$text_file" ]; then
    echo "$text_file is not a file."
    exit 1
fi

if [ ! -f "$dict_file" ]; then
    echo "$dict_file is not a file."
    exit 1
fi


# Process text file and check against dictionary
grep -oE '\b[a-zA-Z]{4}\b' "$text_file" | sort -u | while read word; do
    if ! grep -iq "^$word$" "$dict_file"; then
        echo "$word"
    fi
done
