#!/bin/bash

# Prepare NGINX
echo "Preparing NGINX repository..."

## Retrieve NGINX Keyring
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
  | tee /etc/apt/trusted.gpg.d/nginx.gpg >/dev/null

## Create package list
echo -e "deb https://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" \
  | tee /etc/apt/sources.list.d/nginx.list >/dev/null

## Pin package to make sure the NGINX repo is used
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900" \
  | tee /etc/apt/preferences.d/99nginx >/dev/null

echo "  Successfully prepared NGINX repository!"