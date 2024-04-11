#!/bin/bash

# Hydrate Distro
echo "Hydrating distro..."
apt update -yqqq
apt upgrade -yqqq
echo "  Successfully hydrated distro!"

# Install core dependencies
echo "Installing core dependencies..."
apt install -yqqq gnupg2 wget ca-certificates curl lsb-release apt-transport-https certbot git
echo "  Successfully installed core dependencies!"