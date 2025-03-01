#!/bin/bash
set -e

# Define container and image names
APP_CONTAINER="template-svc"
DB_CONTAINER="template-svc-db"
APP_IMAGE="queuetopia-template-svc"
DB_IMAGE="queuetopia-template-svc-db"

echo "Stopping and removing the Docker containers..."
docker-compose -p queuetopia_template down -v

# Stop and remove database container if running
if docker ps -a --format '{{.Names}}' | grep -q "^$DB_CONTAINER$"; then
    echo "Stopping and removing database container: $DB_CONTAINER..."
    docker stop "$DB_CONTAINER"
    docker rm "$DB_CONTAINER"
else
    echo "Database container $DB_CONTAINER not found."
fi

echo "Removing Docker images..."
docker rmi -f "$APP_IMAGE" || echo "Image $APP_IMAGE not found."
docker rmi -f "$DB_IMAGE" || echo "Image $DB_IMAGE not found."

echo "Cleaning up unused Docker resources..."
docker system prune -af

echo "Checking remaining running containers..."
docker ps -a
