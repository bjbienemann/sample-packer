#!/bin/bash -eux

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

apt update
apt upgrade -y

# Install unzip
sudo apt-get install -y unzip