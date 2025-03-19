#!/bin/bash

echo "== Wittig Server Installation [Node Edition] @ $( cat /etc/hostname ) =="

# Source the prompt utility
source ./utils/prompt.sh

# Core
echo "Bootstrapping installer core..."
/bin/bash ./install/core.sh
echo "  Successfully bootstrapped installer core!"

# Ask for optional components
echo "Optional components:"
prompt_yes_no "Install nginx?" && INSTALL_NGINX=true || INSTALL_NGINX=false
prompt_yes_no "Install MariaDB?" && INSTALL_MARIADB=true || INSTALL_MARIADB=false

# Preparations
echo "Running installer preparations..."
if [ "$INSTALL_NGINX" = true ]; then
  /bin/bash ./prepare/nginx.sh
fi
if [ "$INSTALL_MARIADB" = true ]; then
  /bin/bash ./prepare/mariadb.sh
fi
echo "  Successfully ran installer preparations!"

# Install packages
echo "Installing system packages..."
apt update -yqqq
apt upgrade -yqqq

# Build package list based on selections
PACKAGES=""
if [ "$INSTALL_NGINX" = true ]; then
  PACKAGES="$PACKAGES nginx"
fi
if [ "$INSTALL_MARIADB" = true ]; then
  PACKAGES="$PACKAGES mariadb-server"
fi

# Only install if there are packages to install
if [ ! -z "$PACKAGES" ]; then
  apt install -yqqq $PACKAGES
fi
echo "  Successfully installed system packages!"

# Automatically create users
if [ "$#" -gt 0 ]; then
    echo "Creating users..."

    cd ./create || exit 1
    /bin/bash ./node-user.sh "$@"
    cd ../ || exit 1

    echo "  Successfully created users!"
fi

# Finalization's
echo "Finalizing installation..."
/bin/bash ./finalize/core.sh
printf "%s\n%s\n%s\n== Successfully installed Wittig Server [Node Edition] @ $( cat /etc/hostname ) ==%s\n%s\n%s\n"