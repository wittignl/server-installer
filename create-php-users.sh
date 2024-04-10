#!/bin/bash

for newUser in "$@"
do
    # Create new User
    useradd -m -s /bin/bash $newUser
done
