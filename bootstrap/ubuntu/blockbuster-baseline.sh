#!/usr/bin/env bash

set -Eeuo pipefail

STANDARD_USER="ced4568"

echo "Updating package metadata..."
sudo apt update

echo "Installing baseline packages..."
sudo apt install -y \
  vim \
  git \
  curl \
  wget \
  unzip \
  zip \
  jq \
  tree \
  btop \
  tmux \
  htop \
  ncdu \
  rsync \
  ca-certificates \
  gnupg \
  lsb-release

echo "Creating standard directories..."
sudo mkdir -p \
  /opt/stacks \
  /opt/platform \
  /opt/backups \
  /opt/scripts \
  /opt/docs \
  /opt/logs

sudo chown -R "${STANDARD_USER}:${STANDARD_USER}" \
  /opt/stacks \
  /opt/platform \
  /opt/scripts \
  /opt/docs

echo "Baseline complete."
