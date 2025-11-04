#!/bin/bash

# Backup script to Automatically backup files and upload to S3 bucket

#configurable variables
SOURCE_DIR="/home/ubuntu/Documents"
BACKUP_DIR="/home/ubuntu/Backups"
TIMESTAMP=$(date +"%Y%m%d_%H-%M-%S")
S3_BUCKET="s3://s3-bashscript-bucket"   

# --- Check if AWS CLI is installed ---
if ! command -v aws >/dev/null 2>&1; then
    echo "AWS CLI is not installed. Please install it before running this script."
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create a compressed tarball of the source directory
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

# Verify if the backup was created successfully
if [ $? -eq 0 ]; then
    echo "Backup created successfully: $BACKUP_FILE"
else
    echo "Error creating backup"
    exit 1
fi

# Upload the backup to S3 bucket
aws s3 cp "$BACKUP_FILE" "$S3_BUCKET/"

# Verify if the upload was successful
if [ $? -eq 0 ]; then
    echo "Backup uploaded successfully to S3: $S3_BUCKET/"
else
    echo "Error uploading backup to S3"
    exit 1
fi


# Remove backups older than 7 days for local storage
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm {} \; 
echo "Old backups removed"
echo "Backup process completed."

# End of script
