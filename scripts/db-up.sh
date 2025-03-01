#!/bin/bash
set -e

# Default compose file
COMPOSE_FILE="scripts/docker-compose-db.yml"

echo "Starting the PostgreSQL container..."
docker-compose -f "$COMPOSE_FILE" -p queuetopia_template up -d template-svc-postgres

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to start..."
until docker exec template-svc-db pg_isready -U postgres > /dev/null 2>&1; do
    sleep 2
    echo "PostgreSQL is still starting..."
done

echo "✅ PostgreSQL is up and running!"
