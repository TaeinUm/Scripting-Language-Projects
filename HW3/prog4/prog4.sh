#!/bin/bash


# Parse Command-Line Arguments
if [ "$#" -ne 1 ]; then
    echo "Score directory missing."
    exit 1
fi

scores_dir=$1

# Validate the directory
if [ ! -d "$scores_dir" ]; then
    echo "/$scores_dir is not a directory."
    exit 1
fi


# Calculate and display grade for a single file
calculate_grade() {
    local file="$1"
    while IFS=, read -r id q1 q2 q3 q4 q5; do
        if [[ $id != "ID" ]]; then # Skip header line
            local total_score=$((q1 + q2 + q3 + q4 + q5))
            local percentage=$((total_score * 2)) # Each question is out of 10, total 50

            # Assign letter grade
            if [ "$percentage" -ge 93 ]; then
                grade="A"
            elif [ "$percentage" -ge 80 ]; then
                grade="B"
            elif [ "$percentage" -ge 65 ]; then
                grade="C"
            else
                grade="D"
            fi

            echo "$id:$grade"
        fi
    done < "$file"
}

# Process each score file
export -f calculate_grade
find "$scores_dir" -type f -exec bash -c 'calculate_grade "$0"' {} \;
