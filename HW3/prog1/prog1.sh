#!/bin/bash


# Parse Command-Line Arguments
if [ "$#" -ne 2 ]; then
    echo "src and dest dirs missing."
    exit 1
fi

src_dir=$1
dest_dir=$2


# Validate source directory
if [ ! -d "$src_dir" ]; then
    echo "/$src_dir not found."
    exit 0
fi


# Create the destination directory if it doesn't exist
mkdir -p "$dest_dir"


# Step 4: Find and Move C Files
move_files() {
    local src_dir="$1"
    local dest_dir="$2"

    # Count .c files in the source directory
    local c_file_count=$(find "$src_dir" -maxdepth 1 -type f -name "*.c" | wc -l)

    # If more than three C files are found, ask for user confirmation
    if [ "$c_file_count" -gt 3 ]; then
        echo "Found more than three C files in directory /$src_dir. Move files? (Y/N)"
        read -r user_input
        if [[ ! $user_input =~ ^[Yy]$ ]]; then
            echo "Skipping directory $src_dir."
            return # Skip this directory if user input is not 'Y' or 'y'
        fi
    fi

    # Proceed with moving files
    for file in "$src_dir"/*.c; do
        if [ -f "$file" ]; then # Check if there are any C files
            mkdir -p "$dest_dir" # Ensure the destination directory exists
            mv "$file" "$dest_dir"
        fi
    done
}

# Export the function for use in find -exec
export -f move_files

# Use find to apply move_files function to each directory in the source directory
find "$src_dir" -type d -exec bash -c 'move_files "$0" "${0/#'$src_dir'/'$dest_dir'}"' {} \;

echo "Operation completed."
