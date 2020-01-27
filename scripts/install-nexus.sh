#!/bin/bash -eux

# References
# https://stackoverflow.com/questions/57028412/how-to-install-nexus-on-ubuntu-18-04

wget http://download.sonatype.com/nexus/3/nexus-3.20.1-01-unix.tar.gz -P /tmp

sudo tar xf /tmp/nexus-3.20.1-01-unix.tar.gz -C /opt

sudo ln -s /opt/nexus-3.20.1-01 /opt/nexus

# Add user nexus
sudo adduser --quiet --disabled-password --gecos "Sonatype Nexus" nexus
echo "nexus:nexus123" | chpasswd

# Set no password for nexus user and enter below command to edit sudo file
# Add the below line and Save. nexus ALL=(ALL) NOPASSWD: ALL
# sudo visudo
echo "nexus        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Change file and owner permission for nexus files
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

# Open /opt/nexus/bin/nexus.rc file, uncomment run_as_user parameter and set it as following.
# run_as_user="nexus" (file shold have only this line)
# sudo vim /opt/nexus/bin/nexus.rc
sudo sed -i 's/#run_as_user=""/run_as_user="nexus"/' /opt/nexus/bin/nexus.rc

# Add nexus as a service at boot time
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus

# Runs as a Service
# Usage: service nexus { console | start | stop | restart | status | dump }"
sudo update-rc.d nexus defaults

# Log in as a nexus user and start service
# su - nexus
# /etc/init.d/nexus start

# Check the port is running or not using netstat command
# sudo netstat -plnt

# Admin password
# cat /opt/sonatype-work/nexus3/admin.password