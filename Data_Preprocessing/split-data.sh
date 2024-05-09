#!/bin/bash -l

echo "Start job split script"

# Define the initial file to split
file1="train.de"  # path to train.de
file2="train.en" # path to train.en

# Function to split the file by lines, rename the first half, and delete the second half
split_and_rename() {
    local input_file="$1"
    local output_file="$2"

    total_lines=$(wc -l < "$input_file")
    half_lines=$((total_lines / 2))
    head -n $half_lines "$input_file" > "$output_file"
}

# Perform 7 iterations of splitting and renaming (train.de)
if [ ! -f $file1 ]; then
    echo "train.de file not found!"
else
    previous_file=$file1
    for ((i=1; i<7; i++)); do
        new_file="train$(($i+1)).de"
        split_and_rename "$previous_file" "$new_file"
        previous_file="$new_file"
    done
fi

# Perform 7 iterations of splitting and renaming (train.en)
if [ ! -f $file2 ]; then
    echo "train.en file not found!"
else
    previous_file=$file2
    for ((i=1; i<7; i++)); do
        new_file="train$(($i+1)).en"
        split_and_rename "$previous_file" "$new_file"
        previous_file="$new_file"
    done
fi

echo "Finished job split script"