#!/bin/bash -eux

# References
# https://developerinsider.co/install-sonarqube-on-ubuntu/
# https://www.digitalocean.com/community/tutorials/how-to-ensure-code-quality-with-sonarqube-on-ubuntu-18-04

# Depends java 11+ and postgresql 9.5+

wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.1.0.31237.zip -P /tmp

sudo unzip -q /tmp/sonarqube-8.1.0.31237.zip -d /opt

# sudo mv /tmp/sonarqube-8.1.0.31237/* /opt/sonarqube/
sudo ln -s /opt/sonarqube-8.1.0.31237 /opt/sonarqube

# echo "sonar:sonar123" | sudo chpasswd
# sudo adduser --quiet --disabled-password --gecos "SonarQube" sonar
sudo groupadd --system sonar
sudo adduser \
    --system \
    --disabled-login \
    --no-create-home \
    --gecos '' \
    --ingroup sonar \
    --home /opt/sonarqube \
    sonar

# sudo install -d -o root -g sonar -m 751 /opt/sonarqube
sudo chown -R sonar:sonar /opt/sonarqube
sudo chown -R sonar:sonar /opt/sonarqube-8.1.0.31237/
sudo mkdir -p /var/sonarqube/data/
sudo chown -R sonar:sonar /var/sonarqube/data/
sudo mkdir -p /var/sonarqube/temp/
sudo chown -R sonar:sonar /var/sonarqube/temp/

# Create a new user sonar
# sudo -u postgres createuser sonar
# sudo -u postgres psql -c "ALTER USER sonar WITH ENCRYPTED password 'sonar123';"
# sudo -sHu postgres psql -c "create role sonar login password 'sonar123'"
sudo -sHu postgres psql -c "CREATE ROLE sonar LOGIN PASSWORD 'sonar123'"

# Create database for sonar user
sudo -sHu postgres pg_dumpall > /tmp/postgres.sql
sudo -sHu postgres pg_dropcluster --stop 9.5 main
sudo -sHu postgres pg_createcluster --locale en_US.UTF-8 --start 9.5 main
sudo -sHu postgres psql -f /tmp/postgres.sql
sudo -sHu postgres createdb -E UTF8 -O sonar sonarqube

sudo sed -i "s/#sonar.jdbc.username=/sonar.jdbc.username=sonar/" /opt/sonarqube/conf/sonar.properties
sudo sed -i "s/#sonar.jdbc.password=/sonar.jdbc.password=sonar123/" /opt/sonarqube/conf/sonar.properties

sudo sed -i "s/#sonar.jdbc.url=jdbc:postgresql:\\/\\/localhost\\/sonarqube?currentSchema=my_schema/sonar.jdbc.url=jdbc:postgresql:\\/\\/localhost\\/sonarqube/" /opt/sonarqube/conf/sonar.properties

sudo sed -i "s/#sonar.path.data=data/sonar.path.data=\\/var\\/sonarqube\\/data/" /opt/sonarqube/conf/sonar.properties
sudo sed -i "s/#sonar.path.temp=temp/sonar.path.temp=\\/var\\/sonarqube\\/temp/" /opt/sonarqube/conf/sonar.properties

# SonarQube to run in server mode
sudo sed -i "s/#sonar.web.javaAdditionalOpts=/sonar.web.javaAdditionalOpts=-server/" /opt/sonarqube/conf/sonar.properties

sudo sed -i 's@wrapper.java.command=java@'"wrapper.java.command=${JAVA_HOME}\\/bin\\/java"'@' /opt/sonarqube/conf/wrapper.conf

sudo bash -c "cat > /etc/sysctl.d/98-elasticsearch.conf << 'EOF'
vm.max_map_count = 262144
fs.file-max = 65535
EOF" 
sudo systemctl restart procps

# Configure Systemd service
sudo bash -c "cat > /etc/systemd/system/sonarqube.service << 'EOF' 
[Unit]
Description=sonarqube
After=network.target

[Service]
Type=simple
User=sonar
Group=sonar
LimitNOFILE=infinity
LimitMEMLOCK=infinity
WorkingDirectory=/opt/sonarqube
ExecStartPre=/bin/sh -c 'ulimit -a; sysctl fs.nr_open vm.max_map_count'
ExecStart=/usr/bin/nohup \
    /usr/bin/java \
    -Djava.net.preferIPv4Stack=true \
    -jar /opt/sonarqube/lib/sonar-application-8.1.0.31237.jar \
    -Dsonar.log.console=true
TimeoutStartSec=5
Restart=always
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
EOF"

sudo systemctl enable sonarqube
sudo systemctl start sonarqube

# Add folder in environment variable

# start with operational system

# ES_JAVA_OPTS="-Xms2g -Xmx2g" ./bin/linux-x86-64/sonar.sh console

# sysctl vm.max_map_count
# sysctl fs.file-max
# ulimit -n
# ulimit -u

# sudo sysctl -w vm.max_map_count=262144 &&
# sudo sysctl -w fs.file-max=65535 &&
# ulimit -n 65535 &&
# ulimit -u 4096