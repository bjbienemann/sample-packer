#!/bin/bash -eux

# Install Dependencies
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –

# Install the Docker Repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"

# Update Repositories
sudo apt-get update

# Install Latest Version of Docker
sudo apt-get install docker-ce

# sudo usermod -aG docker ${USER}

# List groups add on user
# id -nG