#!/bin/bash -eux

# https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-18-04/

wget https://www-eu.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp

tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt

ln -s /opt/apache-maven-3.6.3 /opt/maven

# Add folder in environment variable
echo "export M2_HOME=/opt/maven" > /etc/profile.d/maven.sh &&
echo "export MAVEN_HOME=/opt/maven" >> /etc/profile.d/maven.sh &&
echo "export PATH=/opt/maven/bin:${PATH}" >> /etc/profile.d/maven.sh

chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh