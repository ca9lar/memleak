#!/bin/bash

# Set the maximum number of iterations to check for memory leaks
max_iterations=10

# Set the interval between iterations (in seconds)
interval=60

# Initialize counters
iteration=1
leak_detected=0

echo "Starting memory leak detection..."

# Loop until the maximum number of iterations is reached
while [ $iteration -le $max_iterations ]
do
    # Check for processes with increasing resident memory usage
    increasing_memory=$(ps aux --sort -rss | awk '
    NR == 1 {
        prev_pid=$2
        prev_rss=$6
        print
    }
    NR > 1 {
        if ($2 != prev_pid && $6 > prev_rss) {
            print
        }
        prev_pid=$2
        prev_rss=$6
    }
    ')

    # Check if any processes were found
    if [ -n "$increasing_memory" ]
    then
        # Set the leak detected flag and print the output
        leak_detected=1
        echo "Memory leak detected at iteration $iteration:"
        echo "$increasing_memory"
    fi

    # Increment the iteration counter
    iteration=$((iteration+1))

    # Sleep for the specified interval before the next iteration
    sleep $interval
done

# Check if a leak was detected
if [ $leak_detected -eq 0 ]
then
    echo "No memory leaks detected after $max_iterations iterations."
else
    echo "Memory leak detection complete."
fi
