#!/bin/bash
# health-check.sh
# Checks disk, memory and the app, and prints OK or WARNING

set -u

DISK_LIMIT=80
MEM_LIMIT=80
APP_URL="http://127.0.0.1:8080"
PROBLEMS=0

# 1. Disk check
DISK_USED=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
if [ "$DISK_USED" -ge "$DISK_LIMIT" ]; then
  echo "WARNING: Disk is ${DISK_USED}% full"
  PROBLEMS=$((PROBLEMS + 1))
else
  echo "OK: Disk is ${DISK_USED}% full"
fi

# 2. Memory check
MEM_USED=$(free | awk '/Mem:/ {printf "%d", ($3/$2)*100}')
if [ "$MEM_USED" -ge "$MEM_LIMIT" ]; then
  echo "WARNING: Memory is ${MEM_USED}% used"
  PROBLEMS=$((PROBLEMS + 1))
else
  echo "OK: Memory is ${MEM_USED}% used"
fi

# 3. App check
if curl -s --max-time 5 "$APP_URL" > /dev/null; then
  echo "OK: App is answering at $APP_URL"
else
  echo "WARNING: App is NOT answering at $APP_URL"
  PROBLEMS=$((PROBLEMS + 1))
fi

# Final result
if [ "$PROBLEMS" -eq 0 ]; then
  echo "RESULT: Everything is healthy"
  exit 0
else
  echo "RESULT: $PROBLEMS problem(s) found"
  exit 1
fi
