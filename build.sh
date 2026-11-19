#!/bin/bash
# Usage: ./build.sh <dev|prod>
set -e

ENV=${1:-dev}
DOCKER_USER="bushwilson"
IMAGE="$DOCKER_USER/$ENV"

echo "Building image $IMAGE:latest ..."
docker build -t $IMAGE:latest .
echo "Build complete: $IMAGE:latest"