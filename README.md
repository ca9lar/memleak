# memleak
This script will continuously check for processes that have increasing resident memory usage over a series of iterations. It uses the ps command to list all running processes and their resource usage, and the awk command to filter out any processes that are not increasing in memory usage. The script will run for a specified number of iterations, with a specified interval between each iteration, and will print any processes that are found to have increasing memory usage.

