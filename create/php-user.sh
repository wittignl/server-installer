#!/bin/bash

for newUser in "$@"
do
    # Create new User
    /bin/bash ./user.sh "$newUser"
done