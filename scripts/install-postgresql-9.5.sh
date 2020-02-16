#!/bin/bash -eux

wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

sudo apt-get update

# Install PostgreSQL server
sudo apt-get -y install postgresql-9.5 postgresql-contrib-9.5

# Start and enable it to start automatically at boot time by running.
# sudo systemctl start postgresql
# sudo systemctl enable postgresql

# Alter password for postgres user
echo "postgres:postgres123" | sudo chpasswd

# Graphical administration tool pgAdmin4
# http://127.0.0.1:46245/browser/
# sudo apt-get -y install pgadmin4