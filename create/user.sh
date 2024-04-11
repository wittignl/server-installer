#!/bin/bash

# Ensure at least one user is specified to be created.
if [ "$#" -lt 1 ]; then
    echo "Specify at least one username"
    exit 1
fi

# Iterate through each user and create them.
for newUser in "$@"
do
    # Create new User
    useradd -m -s /bin/bash "$newUser"

    # Generate SSH keypair
    sudo -H -u "$newUser" bash -c 'ssh-keygen -q -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa'
done