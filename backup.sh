#!/bin/bash

# Define variables
bucket="s3://slonig/"
CONTAINER_NAME="slonig-dev"
VOLUME_NAME="ws-parachain-1slonigiraforg_slonig-dev"
BACKUP_PATH="/home/ubuntu/tmp"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE_NAME="slonig-dev_backup_$TIMESTAMP.tar.gz"

# Stop the Docker container
docker-compose -f /srv/www/ws-parachain-1.slonigiraf.org/docker-compose.yml down

# Backup the Docker volume
docker run --rm -v $VOLUME_NAME:/volume -v $BACKUP_PATH:/backup alpine tar czf /backup/$BACKUP_FILE_NAME /volume

# Restart the Docker container
docker-compose -f /srv/www/ws-parachain-1.slonigiraf.org/docker-compose.yml up -d

echo -e "Uploading of $BACKUP_FILE_NAME"
s3cmd put "$BACKUP_PATH/$BACKUP_FILE_NAME" "$bucket"

echo -e "Deleting tmp file $BACKUP_FILE_NAME"
rm -f "$BACKUP_PATH/$BACKUP_FILE_NAME"

echo "Backup of $VOLUME_NAME completed: $BACKUP_PATH/$BACKUP_FILE_NAME"