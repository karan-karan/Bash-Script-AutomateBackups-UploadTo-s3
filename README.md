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
git clone https://github.com/karan-karan/Bash-Script-AutomateBackups-UploadTo-s3.git
cd Bash-Script-AutomateBackups-UploadTo-s3
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

### Manual Execution
Simply run the script:
```bash
./Backup\&upload.sh
```

The script will:
1. Create a timestamped backup of your source directory
2. Upload the backup to your specified S3 bucket
3. Remove local backups older than 7 days
<img width="740" height="92" alt="image" src="https://github.com/user-attachments/assets/74271370-5a02-441e-8cf4-cbc27f75dc30" />


### Automated Execution with Crontab

To automate the backup process, you can set up a cron job:

1. Open your crontab configuration:
```bash
crontab -e
```

2. Add one of these example schedules:
```bash
# Run daily at 2 AM
0 2 * * * /full/path/to/Backup\&upload.sh

# Run weekly on Sunday at 3 AM
0 3 * * 0 /full/path/to/Backup\&upload.sh

# Run monthly on the 1st at 4 AM
0 4 1 * * /full/path/to/Backup\&upload.sh
```

Make sure to use the full absolute path to the script in your crontab entry.

#### Crontab Format Explanation
```
* * * * * command
│ │ │ │ │
│ │ │ │ └─── Day of the week (0-6, 0 is Sunday)
│ │ │ └───── Month (1-12)
│ │ └─────── Day of the month (1-31)
│ └───────── Hour (0-23)
└─────────── Minute (0-59)
```

To view your current cron jobs:
```bash
crontab -l
```

Note: The script's output will be sent to the system mail by default. You might want to add logging to the script if you need to track its execution.

## Error Handling

The script includes checks for:
- AWS CLI installation
- Backup creation success
- S3 upload success

## Maintenance

Local backups older than 7 days are automatically removed to prevent disk space issues.

## Must know details

Create an IAM Role for EC2 S3 Access

To allow your EC2 instance to upload backups to S3 securely, you should use an IAM Role instead of embedding AWS credentials. This is more secure and recommended for production.
Steps:
- Go to IAM Roles in AWS Console
- Click Create Role → Select AWS Service → EC2 → Next
- Attach the policy AmazonS3FullAccess (or a custom policy with access to your specific bucket)
- Give your role a name (e.g., EC2S3BackupRole) and create it
Using an IAM Role ensures your EC2 instance automatically has the required permissions to access S3, without storing keys on the instance.

Attach IAM Role to EC2 Instance
- Navigate to EC2 → Instances → Select your instance
- Click Actions → Security → Modify IAM Role
- Select the role you created (EC2S3BackupRole) → Update
- Once attached, the EC2 instance can access S3 directly using the role. No AWS keys or aws configure setup is needed.

S3 Lifecycle Rules for Automatic Cleanup
Instead of manually deleting old backups from S3 in the script, you can configure Lifecycle Rules in your S3 bucket:
- Go to S3 → Your Bucket → Management → Lifecycle Rules
- Create a rule to delete objects older than X days (e.g., 7 days)
- Save the rule
This approach is simpler and more reliable, as it automatically cleans up old backups without modifying the script.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
