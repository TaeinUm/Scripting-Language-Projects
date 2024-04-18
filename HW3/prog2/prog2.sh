#!/bin/bash


# Parse Command-Line Arguments
if [ "$#" -ne 2 ]; then
    echo "Data file or output file not found."
    exit 1
fi

data_file="$1"
output_file="$2"


# Validate data file
if [ ! -f "$data_file" ]; then
    echo "$data_file not found."
    exit 1
fi


# Initialize an array to hold the sums of each column
declare -a sums


# Read and Process the Data File
while IFS= read -r line; do
    # Replace delimiters with spaces and split into an array
    IFS=',:;' read -ra nums <<< "$line"
    for i in "${!nums[@]}"; do
        # Add each number to its respective column's sum
        sums[i]=$((${sums[i]:-0} + ${nums[i]}))
    done
done < "$data_file"


# Write Results to the Output File
> "$output_file" # Clear the output file
for i in "${!sums[@]}"; do
    echo "Col $((i + 1)) : ${sums[i]}" >> "$output_file"
done


echo "Calculation completed. Results are written to $output_file."
