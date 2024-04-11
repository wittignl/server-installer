#!/bin/bash

# Ensure at least one user is specified to be created.
if [ "$#" -lt 1 ]; then
    echo "Specify at least one username"
    exit 1
fi

# Iterate through each user and create them.
for newUser in "$@"
do
    echo "Creating UNIX user '$newUser'..."

    # Create new User
    useradd -m -s /bin/bash "$newUser"

    # Generate SSH keypair
    echo "  Generating SSH keypair..."
    sudo -H -u "$newUser" bash -c 'ssh-keygen -q -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa'
    echo "  Successfully generated SSH keypair!"

    echo "  Successfully created UNIX user '$newUser'!"
done