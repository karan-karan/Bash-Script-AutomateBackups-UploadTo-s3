# Automated Backup to AWS S3

This Bash script automates the process of creating backups and uploading them to an AWS S3 bucket. It compresses specified directories into a tarball and manages local backup retention.

## Features

- Creates compressed backups of specified directories
- Automatically uploads backups to AWS S3
- Maintains local storage by removing old backups
- Includes error handling and verification steps
- Configurable backup source and destination paths

## Prerequisites

- Linux/Unix environment
- AWS CLI installed and configured
- Appropriate AWS credentials and permissions
- Sufficient storage space for backups

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/automated-s3-backup.git
cd automated-s3-backup
```

2. Make the script executable:
```bash
chmod +x Backup\&upload.sh
```

## Configuration

Edit the following variables in the script to match your environment:

```bash
SOURCE_DIR="/home/ubuntu/Documents"    # Directory to backup
BACKUP_DIR="/home/ubuntu/Backups"      # Where to store local backups
S3_BUCKET="s3://s3-bashscript-bucket" # Your S3 bucket name
```

## Usage

Simply run the script:
```bash
./Backup\&upload.sh
```

The script will:
1. Create a timestamped backup of your source directory
2. Upload the backup to your specified S3 bucket
3. Remove local backups older than 7 days

## Error Handling

The script includes checks for:
- AWS CLI installation
- Backup creation success
- S3 upload success

## Maintenance

Local backups older than 7 days are automatically removed to prevent disk space issues.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.