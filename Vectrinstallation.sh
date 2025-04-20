#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt-get update

# Install required dependencies
echo "Installing required packages..."
sudo apt-get install -y ca-certificates curl git wget unzip

# Add Docker’s official GPG key
echo "Adding Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
echo "Installing Docker..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Install VECTR
echo "Installing VECTR..."
sudo mkdir -p /opt/vectr && cd /opt/vectr
sudo wget https://github.com/SecurityRiskAdvisors/VECTR/releases/download/ce-9.7.0/sra-vectr-runtime-9.7.0-ce.zip 
sudo unzip sra-vectr-runtime-9.7.0-ce.zip

# Update hosts file
echo "Updating hosts file..."
echo "127.0.0.1 sravectr.internal" | sudo tee -a /etc/hosts

# Start VECTR using Docker Compose
echo "Starting VECTR..."
cd /opt/vectr
sudo docker compose up -d
echo "VECTR installation complete!"
