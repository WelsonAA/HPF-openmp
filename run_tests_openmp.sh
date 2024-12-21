#!/bin/bash

# Define resolutions and thread counts to test
resolutions=("360" "480" "720" "1080" "2K" "4K")
threads=("1" "2" "3" "4" "5" "6" "7" "8")  # Adjust based on your hardware

# Loop through all combinations of resolutions and threads
for resolution in "${resolutions[@]}"; do
    for thread in "${threads[@]}"; do
        # Run the OpenMP quick test script and capture output
        output=$(./quick_run_openmp.sh "$resolution" "$thread")

        # Print formatted result
        echo "RESOLUTION: $resolution, THREADS: $thread, RESULT: $output"
    done
done
