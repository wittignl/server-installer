#!/bin/bash

# Core
/bin/bash ./install/core.sh

# Preparations
/bin/bash ./prepare/nginx.sh
/bin/bash ./prepare/mariadb.sh

# Install packages
apt update -y
apt upgrade -y
apt install -y nginx mariadb-server

# Automatically create users
if [ "$#" -gt 0 ]; then
  /bin/bash ./create/node-user.sh "$@"
fi