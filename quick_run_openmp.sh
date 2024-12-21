#!/bin/bash

# Usage: ./quick_run_openmp.sh <resolution> <threads>
# Example: ./quick_run_openmp.sh 360 8

# Check if arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <resolution: 360|480|720|1080|2K|4K> <threads: 1|2|4|8|16>"
    exit 1
fi

# Assign input arguments
resolution=$1
threads=$2

# Define image paths based on resolution
case $resolution in
    360) image_path="./random_noise_images/random_noise_360p.png" ;;
    480) image_path="./random_noise_images/random_noise_480p.png" ;;
    720) image_path="./random_noise_images/random_noise_720p.png" ;;
    1080) image_path="./random_noise_images/random_noise_1080p.png" ;;
    2K) image_path="./random_noise_images/random_noise_2K.png" ;;
    4K) image_path="./random_noise_images/random_noise_4K.png" ;;
    *) echo "Invalid resolution. Use 360, 480, 720, 1080, 2K, or 4K."; exit 1 ;;
esac

# Check if the image file exists
if [ ! -f "$image_path" ]; then
    echo "Error: Image file '$image_path' not found."
    exit 1
fi

# Set the number of OpenMP threads
export OMP_NUM_THREADS=$threads

# Path to the OpenMP executable
EXECUTABLE="./build_openmp/high_pass_filter"

# Check if the executable exists
if [ ! -f "$EXECUTABLE" ]; then
    echo "Error: Executable '$EXECUTABLE' not found. Build the project first."
    exit 1
fi

# Run the benchmark
./run_openmp.sh -t $threads -f 9 -p "$image_path" -m 2>/dev/null | grep "Time (mean ± σ):" | awk -F': *' '{print $2}' | awk '{print $1, $2, $3, $4, $5}'
