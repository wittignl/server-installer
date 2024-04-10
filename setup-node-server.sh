#!/bin/bash

/bin/bash ./install-core.sh
/bin/bash ./prepare-nginx.sh
/bin/bash ./prepare-mariadb.sh

# Install packages
apt update -y
apt upgrade -y
apt install -y nginx mariadb-server

# Automatically create users
if [test -f ./create-node-users.sh] AND [ "$#" -gt 0 ]; then
  /bin/bash ./create-node-users.sh "$@"
fi
