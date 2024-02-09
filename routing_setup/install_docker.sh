#!/bin/bash

# Update the package index
sudo apt update

# Install packages to allow apt to use a repository over HTTPS
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker to run on system boot
sudo systemctl start docker
sudo systemctl enable docker

# Add the current user to the 'docker' group to avoid using 'sudo' with Docker commands
sudo usermod -aG docker $USER

# Print Docker version
docker --version

echo "Docker installation completed."

