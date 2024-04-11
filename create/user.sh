#!/bin/bash

# Create new User
useradd -m -s /bin/bash "$1"

# Generate SSH keypair
sudo -H -u "$1" bash -c 'ssh-keygen -q -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa'