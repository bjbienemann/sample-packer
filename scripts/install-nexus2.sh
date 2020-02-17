#!/bin/bash -eux

# References
# https://help.sonatype.com/repomanager2/
# https://itcloudnet.blogspot.com/2015/06/how-to-install-and-manage-sonatype.html
# https://askubuntu.com/questions/930639/make-service-monit-possible-for-a-particular-user-to-start-without-prompting-for

# sudo apt install -y policykit-1

# Depends on java 8

wget -q http://www.sonatype.org/downloads/nexus-2.14.5-02-bundle.tar.gz -P /tmp

sudo tar xf /tmp/nexus-2.14.5-02-bundle.tar.gz -C /opt

sudo ln -s /opt/nexus-2.14.5-02 /opt/nexus

# Add user nexus
# sudo adduser --quiet --disabled-password --gecos "Sonatype Nexus" nexus
# echo "nexus:nexus123" | chpasswd
sudo groupadd --system nexus
sudo adduser \
    --system \
    --disabled-login \
    --no-create-home \
    --gecos '' \
    --ingroup nexus \
    --home /opt/nexus \
    nexus

# Add sudo permissions
# sudo usermod -aG sudo nexus

# Add nexus user to sudoers
# echo "nexus        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Change file and owner permission for nexus files
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/nexus-2.14.5-02
sudo chown -R nexus:nexus /opt/sonatype-work

# Change RUN_AS_USER for nexus user
sudo sed -i 's/#RUN_AS_USER=/RUN_AS_USER="nexus"/' /opt/nexus/bin/nexus

# Add nexus as a service at boot time
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus

# Runs as a Service
# Usage: service nexus { console | start | stop | restart | status | dump }"
sudo update-rc.d nexus defaults

# List all services
# sudo systemctl list-unit-files --type service --all

# View nexus logs
# tail -f /usr/local/nexus/logs/wrapper.log

sudo bash -c "cat > /etc/polkit-1/localauthority/50-local.d/nexus.pkla << 'EOF'
[nexus service]
Identity=unix-user:nexus
Action=org.freedesktop.systemd1.manage-units
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF"