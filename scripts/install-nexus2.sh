#!/bin/bash -eux

# References
# https://itcloudnet.blogspot.com/2015/06/how-to-install-and-manage-sonatype.html

wget -q http://www.sonatype.org/downloads/nexus-2.14.5-02-bundle.tar.gz -P /tmp

sudo tar xf /tmp/nexus-2.14.5-02-bundle.tar.gz -C /opt

sudo ln -s /opt/nexus-2.14.5-02 /opt/nexus

# View nexus logs
# tail -f /usr/local/nexus/logs/wrapper.log