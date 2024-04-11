#!/bin/bash

echo "== Wittig Server Installation [PHP Edition] @ $( cat /etc/hostname ) =="

# Core
echo "Bootstrapping installer core..."
/bin/bash ./install/core.sh
echo "Successfully bootstrapped installer core!"

# Preparations
echo "Running installer preparations..."
/bin/bash ./prepare/nginx.sh
/bin/bash ./prepare/mariadb.sh
/bin/bash ./prepare/php.sh
echo "Successfully ran installer preparations!"

# Install packages
echo "Installing system packages..."
apt update -yqqq
apt upgrade -yqqq
apt install -yqqq nginx mariadb-server imagemagick libpcre3-dev php8.3 \
  php8.3-{bcmath,bz2,curl,exif,fpm,fileinfo,gettext,gd,intl,imagick,json,mbstring,memcached,openssl,pdo,pdo_mysql,pdo_sqlite,phalcon5,readline,redis,xml,zip}
echo "Successfully installed system packages!"

# Automatically create users
if [ "$#" -gt 0 ]; then
    echo "Creating users..."
    /bin/bash ./create/php-user.sh "$@"
    echo "Successfully created users!"
fi