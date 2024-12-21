#!/bin/bash

# Set the path to your build directory
BUILD_DIR="./build_openmp"

# Default values for arguments
DEBUG=false
NUM_THREADS=1       # Default number of threads
FILTER_SIZE=3       # Default filter size
IMAGE_PATH=""       # Default image path
OPEN_IMAGES=false   # Default: Do not open images
MEASURE_TIME=false  # Default: Do not measure time

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d) DEBUG=true ;;                  # Enable debug mode
        -t) NUM_THREADS="$2"; shift ;;     # Set number of threads
        -f) FILTER_SIZE="$2"; shift ;;     # Set filter size
        -p) IMAGE_PATH="$2"; shift ;;      # Set image path
        -o) OPEN_IMAGES=true ;;            # Enable opening images
        -m) MEASURE_TIME=true ;;           # Enable measuring time
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

# Function to run commands silently unless DEBUG is enabled
run_command() {
    if [ "$DEBUG" == "true" ]; then
        "$@"  # Print command output
    else
        "$@" >/dev/null 2>&1  # Silence output
    fi
}

# Validate arguments
if [ -z "$IMAGE_PATH" ]; then
    echo "Error: Image path (-p) is required."
    exit 1
fi

if (( FILTER_SIZE % 2 == 0 )); then
    echo "Error: FILTER_SIZE (-f) must be an odd number."
    exit 1
fi

# Ensure the build directory exists and contains the latest executable
if [ ! -d "$BUILD_DIR" ] || [ ! -f "$BUILD_DIR/high_pass_filter" ]; then
    echo "Error: Build directory or executable not found. Please compile the project first."
    exit 1
fi

# Export the number of threads for OpenMP
export OMP_NUM_THREADS=$NUM_THREADS

# Measure and print the execution time if enabled
echo "Running the program with $NUM_THREADS threads, FILTER_SIZE $FILTER_SIZE, and PATH $IMAGE_PATH..."

FULL_COMMAND="$BUILD_DIR/high_pass_filter $FILTER_SIZE $IMAGE_PATH"

if [ "$MEASURE_TIME" == "true" ]; then
    echo "Benchmarking the program..."
    hyperfine -r 10 "$FULL_COMMAND"
else
    $FULL_COMMAND
fi

# Optionally open the images after running
if [ "$OPEN_IMAGES" == "true" ]; then
    open ../output.png
    open "$IMAGE_PATH"
fi
