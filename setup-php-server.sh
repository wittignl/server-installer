#!/bin/bash

echo "== Wittig Server Installation [PHP Edition] @ $( cat /etc/hostname ) =="

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
/bin/bash ./prepare/php.sh
echo "  Successfully ran installer preparations!"

# Install packages
echo "Installing system packages..."
apt update -yqqq
apt upgrade -yqqq

# Build package list based on selections
PACKAGES="imagemagick libpcre3-dev php8.3 php8.3-{common,bcmath,bz2,curl,exif,fpm,fileinfo,gettext,gd,intl,imagick,mbstring,memcached,sqlite3,phalcon5,readline,redis,xml,zip}"

if [ "$INSTALL_NGINX" = true ]; then
  PACKAGES="nginx $PACKAGES"
fi
if [ "$INSTALL_MARIADB" = true ]; then
  PACKAGES="mariadb-server $PACKAGES"
  # Add MySQL PDO extension if MariaDB is installed
  PACKAGES="$PACKAGES php8.3-pdo-mysql"
fi

apt install -yqqq $PACKAGES
echo "  Successfully installed system packages!"

# Automatically create users
if [ "$#" -gt 0 ]; then
    echo "Creating users..."

    cd ./create || exit 1
    /bin/bash ./php-user.sh "$@"
    cd ../ || exit 1

    echo "  Successfully created users!"
fi

# Finalization's
echo "Finalizing installation..."
/bin/bash ./finalize/core.sh
printf "%s\n%s\n%s\n== Successfully installed Wittig Server [PHP Edition] @ $( cat /etc/hostname ) ==%s\n%s\n%s\n"