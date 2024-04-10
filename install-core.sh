#!/bin/bash

# Hydrate Distro
apt update -y   
apt upgrade -y

# Install core dependencies
apt install -y gnupg2 wget ca-certificates curl lsb-release apt-transport-https certbot
