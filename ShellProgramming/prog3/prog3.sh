#!/bin/bash


# Parse Command-Line Arguments
if [ "$#" -lt 1 ]; then
    echo "Missing data file."
    exit 1
fi

data_file="$1"
shift # Shift arguments to leave only weights


# Validate the data file
if [ ! -f "$data_file" ]; then
    echo "$data_file not found."
    exit 1
fi


# Initialize totals
total_weighted_score=0
total_weight=0


# Read and Process the Data File
while IFS=, read -r id q1 q2 q3 q4 q5; do
    if [[ $id != "ID" ]]; then # Skip header line
        # Calculate weighted score for each student
        weighted_score=0
        for i in {1..5}; do
            # Get the score for the question
            score_var="q$i"
            score=${!score_var}

            # Get the weight for the question, default to 1 if not provided
            weight=${!i:-1}
            
            # Calculate weighted score for the question
            weighted_score=$((weighted_score + (score * weight)))
            
            # Accumulate total weight
            total_weight=$((total_weight + weight))
        done
        
        # Accumulate total weighted score
        total_weighted_score=$((total_weighted_score + weighted_score))
    fi
done < "$data_file"

# Output the Result, calculate weighted average rounded towards zero
weighted_average=$((total_weighted_score / total_weight))

echo "Weighted average: $weighted_average"
