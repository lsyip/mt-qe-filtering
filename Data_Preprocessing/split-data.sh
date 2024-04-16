#!/bin/bash -l

#SBATCH --job-name=split-script
#SBATCH --time=00:01:00
#SBATCH --account=comp_sci
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=lyip@villanova.edu

echo "Start job split script"
module load python/3.8
module load gcc/9.3.1

source ~/miniconda/etc/profile.d/conda.sh
conda activate fairseq-env

# Define the initial file to split
initial_file="lorem.txt"

# Make a copy of the initial file to save it
# cp "$initial_file" "lorem.txt"

# Function to split the file by lines, rename the first half, and delete the second half
split_and_rename() {
    local input_file="$1"
    local output_file="$2"

    total_lines=$(wc -l < "$input_file")
    half_lines=$((total_lines / 2))
    head -n $half_lines "$input_file" > "$output_file"
}

# Perform 7 iterations of splitting and renaming
# 
previous_file="lorem.txt"
for ((i=1; i<7; i++)); do
    new_file="$initial_file$(($i+1))"
    split_and_rename "$previous_file" "$new_file"
    previous_file="$new_file"
done

echo "Finished job split script"
