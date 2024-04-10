#!/bin/bash

/bin/bash ./install-core.sh
/bin/bash ./prepare-nginx.sh
/bin/bash ./prepare-mariadb.sh
/bin/bash ./prepare-php.sh

# Install packages
apt update -y
apt upgrade -y
apt install -y nginx mariadb-server imagemagick libpcre3-dev php8.3 \
  php8.3-{ \
    bcmath,bz2,curl,exif,fpm,fileinfo,gettext,gd,\
    intl,imagick,json,mbstring,memcached,openssl,\
    pdo,pdo_mysql,pdo_sqlite,phalcon5,readline,redis,xml,zip\
  }

# Automatically create users
if [test -f ./create-php-users.sh] AND [ "$#" -gt 0 ]; then
  /bin/bash ./create-php-users.sh "$@"
fi
