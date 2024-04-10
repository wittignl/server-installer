#!/bin/bash

# Hydrate Distro
apt update -y
apt upgrade -y

# Install core dependencies
apt install -y gnupg2 wget ca-certificates curl lsb-release apt-transport-https certbot

# Install NGINX
## Install NGINX Keyring
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
  | tee /etc/apt/trusted.gpg.d/nginx.gpg >/dev/null

## Create package list
echo "deb https://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
  | tee /etc/apt/sources.list.d/nginx.list

## Pin package to make sure the NGINX repo is used
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
  | tee /etc/apt/preferences.d/99nginx

# Install MySQL
## Install MariaDB Keyring
wget -qO /etc/apt/trusted.gpg.d/mariadb.pgp https://mariadb.org/mariadb_release_signing_key.pgp

## Create package list
echo "deb https://mirror.mariadb.org/repo/11.3/ubuntu `lsb_release -cs` mariadb main"

## Pin package to make sure the MariaDB repo is used
echo -e "Package: *\nPin: origin mirror.mariadb.org\nPin: release o=mariadb-server\nPin-Priority: 900\n" \
  | tee /etc/apt/preferences.d/99mariadb

# Install remaining packages
apt update -y
apt upgrade -y
apt install nginx mariadb-server
