#!/bin/bash

# Create users
/bin/bash ./user.sh "$@"

# Iterate through each user and install the tooling for them.
for newUser in "$@"
do
    echo "Creating NodeJS user '$newUser'..."

    # Install NVM
    echo "  Installing NVM..."
    sudo -H -u "$newUser" bash -l -c 'curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
    echo "    Successfully installed NVM!"

    # Install NodeJS
    echo "  Installing NodeJS..."
    sudo -H -u "$newUser" bash -l -c 'nvm install --lts'
    echo "    Successfully installed NodeJS $(sudo -H -u "$newUser" bash -l -c 'node -v')!"

    # Install and Setup PNPM
    echo "  Installing PNPM..."
    sudo -H -u "$newUser" bash -l -c 'corepack install --global pnpm@latest && corepack enable pnpm && pnpm setup'
    echo "    Successfully installed PNPM $(sudo -H -u "$newUser" bash -l -c 'pnpm -v')!"

    # Install PM2 and Bunyan
    echo "  Installing PM2 and Bunyan..."
    sudo -H -u "$newUser" bash -l -c 'pnpm add -g pm2 bunyan'
    echo "    Successfully installed PM2 and Bunyan!"

    echo "  Successfully created NodeJS user '$newUser'!"
done