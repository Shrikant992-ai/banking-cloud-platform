#!/bin/bash
# setup-tools-server.sh
# Checks and installs the basic tools needed for the banking project

set -euo pipefail

TOOLS="git curl unzip python3 jq"

echo "Updating package list..."
sudo apt-get update -y

for tool in $TOOLS; do
  if command -v "$tool" > /dev/null 2>&1; then
    echo "OK: $tool is already installed"
  else
    echo "Installing $tool..."
    sudo apt-get install -y "$tool"
  fi
done

echo "All tools are ready."
