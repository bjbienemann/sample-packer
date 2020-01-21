#!/bin/bash -eux

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update

sudo apt install -y jenkins

sudo systemctl start jenkins

#Verify status jenkinhs service
#sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword | cat <(echo -n "initialAdminPassword: ") -
