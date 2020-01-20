#!/bin/bash -eux

sudo apt install -y openjdk-11-jdk

export echo=$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')
/usr/bin/printf "
JAVA_HOME=${JAVA_HOME}" >> /etc/environment