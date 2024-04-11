#!/bin/bash

# Install MySQL
echo "Preparing MariaDB repository..."

## Install MariaDB Keyring
wget -qO /etc/apt/trusted.gpg.d/mariadb.pgp https://mariadb.org/mariadb_release_signing_key.pgp

## Create package list
echo -e "deb [signed-by=/etc/apt/trusted.gpg.d/mariadb.pgp] https://mirror.mariadb.org/repo/11.4/ubuntu $(lsb_release -cs) main" \
  | tee /etc/apt/sources.list.d/mariadb.list

## Pin package to make sure the MariaDB repo is used
echo -e "Package: *\nPin: origin mirror.mariadb.org\nPin: release o=mariadb-server\nPin-Priority: 900" \
  | tee /etc/apt/preferences.d/99mariadb

echo "Successfully prepared MariaDB repository!"