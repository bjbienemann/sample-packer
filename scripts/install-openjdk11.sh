#!/bin/bash -eux

sudo apt install -y openjdk-11-jdk

# echo "export JAVA_HOME=$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')" > /etc/profile.d/java.sh
echo "export JAVA_HOME=$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')" | sudo tee -a /etc/profile.d/java.sh

sudo chmod +x /etc/profile.d/java.sh
source /etc/profile.d/java.sh