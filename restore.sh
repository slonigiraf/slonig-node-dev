#!/bin/bash

# Check if an input was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path-to-backup-file.tar.gz>"
    exit 1
fi

BACKUP_FILE="$1"
VOLUME_NAME="ws-parachain-1slonigiraforg_slonig-dev"
DOCKER_COMPOSE_FILE="./docker-compose.yml"

# Stop Docker containers
echo "Stopping Docker containers..."
docker-compose -f $DOCKER_COMPOSE_FILE down

# Restore the volume
echo "Restoring backup from $BACKUP_FILE to volume $VOLUME_NAME..."
docker run --rm -v $VOLUME_NAME:/volume -v $(dirname $BACKUP_FILE):/backup alpine sh -c "cd /volume && tar xzf /backup/$(basename $BACKUP_FILE) --strip 1"

# Restart the Docker containers
echo "Restarting Docker containers..."
docker-compose -f $DOCKER_COMPOSE_FILE up -d

echo "Restoration complete."