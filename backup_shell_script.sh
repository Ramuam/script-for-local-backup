#!/bin/bash

# Path to backup directory on external hard drive
backup_dir="path/to/dir"

# Path to source directory to be backed up
source_dir="path/to/dir"

# Path to log file
log_file="path/to/dir"

# Wait for the external hard drive to be connected
while [ ! -d "$backup_dir" ]; do
  echo "Waiting for external hard drive to be connected..."
  sleep 1
done

# Calculate and log the transfer speed
#transfer_speed=$(awk '/sent/ {print $8 " " $9}' $log_file)
#echo "Transfer speed: $transfer_speed" >> $log_file

# Get start time in seconds
start_time=$(date +%s)

# Backup the source directory to the backup directory
rsync -avz --ignore-existing --progress "$source_dir" "$backup_dir" 2>&1 
#| tee -a $log_file

# Get end time in seconds
end_time=$(date +%s)

# Calculate the total transfer time in seconds
transfer_time=$(($end_time - $start_time))

# Log the backup start and end times, transfer speed, and paths
echo "#######################################################" >> "$log_file"
echo "Backup started at $(date -d @$start_time)" >> "$log_file"
echo "Backup ended at $(date -d @$end_time)" >> "$log_file"
echo "Total transfer time: $transfer_time seconds" >> "$log_file"
echo "Source: $source_dir" >> "$log_file"
echo "Destination: $backup_dir" >> "$log_file"
echo "-------------------------------------------------------">> "$log_file"
echo "#######################################################">> "$log_file"

