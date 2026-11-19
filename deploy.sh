#!/bin/bash
# Usage: ./deploy.sh <dev|prod>
set -e

ENV=${1:-prod}
DOCKER_USER="bushwilson"
IMAGE="$DOCKER_USER/$ENV:latest"

echo "Deploying $IMAGE ..."
docker pull $IMAGE
docker rm -f react-app 2>/dev/null || true
docker run -d --name react-app -p 80:80 --restart always $IMAGE
echo "Deployed. App running on port 80."