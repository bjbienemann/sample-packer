#!/bin/bash -eux

deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update

# Install PostgreSQL server
sudo apt-get install postgresql-9.5

# Graphical administration tool pgAdmin4
# http://127.0.0.1:46245/browser/
sudo apt-get install pgadmin4