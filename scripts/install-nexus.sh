#!/bin/bash -eux

# References
# https://stackoverflow.com/questions/57028412/how-to-install-nexus-on-ubuntu-18-04

wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz - /tmp

sudo tar -zxvf /tmp/nexus-*-unix.tar.gz -C /opt

# Add user nexus
sudo adduser nexus

# Set no password for nexus user and enter below command to edit sudo file
# Add the below line and Save. nexus ALL=(ALL) NOPASSWD: ALL
# sudo visudo

# Change file and owner permission for nexus files
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

# Open /opt/nexus/bin/nexus.rc file, uncomment run_as_user parameter and set it as following.
# run_as_user="nexus" (file shold have only this line)
# sudo vim /opt/nexus/bin/nexus.rc

# Add nexus as a service at boot time
# sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus

# Log in as a nexus user and start service
# su - nexus
# /etc/init.d/nexus start

# Check the port is running or not using netstat command
# sudo netstat -plnt