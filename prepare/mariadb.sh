#!/bin/bash

# Install MySQL
echo "Preparing MariaDB repository..."

## Install MariaDB Keyring
wget -qO /etc/apt/trusted.gpg.d/mariadb.pgp https://mariadb.org/mariadb_release_signing_key.pgp

## Create package list
echo "deb https://mirror.mariadb.org/repo/11.4/ubuntu $(lsb_release -cs) mariadb main"

## Pin package to make sure the MariaDB repo is used
echo -e "Package: *\nPin: origin mirror.mariadb.org\nPin: release o=mariadb-server\nPin-Priority: 900" \
  | tee /etc/apt/preferences.d/99mariadb

echo "Successfully prepared MariaDB repository!"