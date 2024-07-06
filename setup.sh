#!/bin/bash

# Update package list
apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Create Docker GPG key storage directory
mkdir -p /etc/apt/keyrings

# Download Docker GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again and install Docker and Docker Compose
apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add user to Docker and Jenkins groups
usermod -aG docker $USER && \
    usermod -aG users jenkins \
    usermod -aG docker ubuntu \
    usermod -aG docker jenkins

systemctl reboot
