#!/bin/bash

# Create users
/bin/bash ./user.sh "$@"

# Iterate through each user and install the tooling for them.
for newUser in "$@"
do
    # Install NVM
    sudo -H -u "$newUser" bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'

    # Install NodeJS
    sudo -H -u "$newUser" bash -c 'nvm use node'

    # Install and Setup PNPM
    sudo -H -u "$newUser" bash -c 'corepack enable && corepack use --activate pnpm@latest'

    # Install PM2 and Bunyan
    sudo -H -u "$newUser" bash -c 'pnpm add -g pm2 bunyan'
done