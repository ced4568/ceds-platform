#!/usr/bin/env bash

set -Eeuo pipefail

STANDARD_USER="${SUDO_USER:-ced4568}"

echo "Updating packages..."
sudo apt update
sudo apt upgrade -y

echo "Installing baseline packages..."
sudo apt install -y \
  vim git curl wget unzip zip jq tree btop tmux htop ncdu rsync \
  ca-certificates gnupg lsb-release ufw fail2ban crowdsec \
  unattended-upgrades apt-listchanges

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

echo "Configuring firewall rules without enabling UFW..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp comment "SSH"
sudo ufw allow 80/tcp comment "HTTP"
sudo ufw allow 443/tcp comment "HTTPS"

echo "Enabling services..."
sudo systemctl enable --now docker
sudo systemctl enable --now crowdsec
sudo systemctl enable --now unattended-upgrades

echo "Bootstrap complete."
echo "UFW remains disabled until remote access has been verified."
