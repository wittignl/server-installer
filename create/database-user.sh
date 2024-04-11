#!/bin/bash

# Ensure at least one user is specified to be created.
if [ "$#" -lt 1 ]; then
    echo "Specify at least one username"
    exit 1
fi

# Iterate through each user and create them.
for newUser in "$@"
do
    echo "Creating database user '$newUser'..."
    mysql --execute "CREATE USER '$newUser'@'127.0.0.1';"
    mysql --execute "FLUSH PRIVILEGES;"
    echo "Successfully created database user '$newUser'!"
done