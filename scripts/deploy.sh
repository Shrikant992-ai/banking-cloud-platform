#!/bin/bash
# deploy.sh
# Usage: ./deploy.sh <dev|staging|prod>
# Gets the latest code, restarts the app, and checks it is healthy

set -euo pipefail

ENVIRONMENT="${1:-}"
REPO_DIR="$HOME/banking-cloud-platform"
SERVICE="myapp"

# A function: a small block of code we can reuse by its name
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# 1. Check the input
if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./deploy.sh <dev|staging|prod>"
  exit 1
fi

case "$ENVIRONMENT" in
  dev|staging|prod)
    log "Starting deployment to $ENVIRONMENT"
    ;;
  *)
    echo "Error: '$ENVIRONMENT' is not valid. Use dev, staging or prod."
    exit 1
    ;;
esac

# 2. Get the latest code
log "Pulling latest code..."
git -C "$REPO_DIR" pull

# 3. Restart the app
log "Restarting $SERVICE..."
sudo systemctl restart "$SERVICE"
sleep 3

# 4. Check it is healthy
log "Running health check..."
if "$REPO_DIR/scripts/health-check.sh"; then
  log "Deployment to $ENVIRONMENT SUCCEEDED"
else
  log "Deployment to $ENVIRONMENT FAILED"
  exit 1
fi
