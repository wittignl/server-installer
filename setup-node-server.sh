#!/bin/bash

echo "== Wittig Server Installation [Node Edition] @ $( cat /etc/hostname ) =="

# Core
echo "Bootstrapping installer core..."
/bin/bash ./install/core.sh
echo "Successfully bootstrapped installer core!"

# Preparations
echo "Running installer preparations..."
/bin/bash ./prepare/nginx.sh
/bin/bash ./prepare/mariadb.sh
echo "Successfully ran installer preparations!"

# Install packages
echo "Installing system packages..."
apt update -yqqq
apt upgrade -yqqq
apt install -yqqq nginx mariadb-server
echo "Successfully installed system packages!"

# Automatically create users
if [ "$#" -gt 0 ]; then
    echo "Creating users..."
    sudo -D ./create /bin/bash ./create/node-user.sh "$@"
    echo "Successfully created users!"
fi