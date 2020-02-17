#!/bin/bash -eux

sudo apt install -y openjdk-8-jdk

# echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" > /etc/profile.d/java.sh
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" | sudo tee -a /etc/profile.d/java.sh

sudo chmod +x /etc/profile.d/java.sh
source /etc/profile.d/java.sh