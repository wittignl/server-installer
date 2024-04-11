#!/bin/bash

# Create users
/bin/bash ./user.sh "$@"

# Iterate through each user and install the tooling for them.
for newUser in "$@"
do
    echo "Creating NodeJS user '$newUser'..."

    # Install NVM
    echo "  Installing NVM..."
    sudo -H -u "$newUser" bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
    echo "  Successfully installed NVM!"

    # Install NodeJS
    echo "  Installing NodeJS..."
    sudo -H -u "$newUser" bash -c 'nvm use node'
    echo "  Successfully installed NodeJS!"

    # Install and Setup PNPM
    echo "  Installing PNPM..."
    sudo -H -u "$newUser" bash -c 'corepack enable && corepack use --activate pnpm@latest'
    echo "  Successfully installed PNPM!"

    # Install PM2 and Bunyan
    echo "  Installing PM2 and Bunyan..."
    sudo -H -u "$newUser" bash -c 'pnpm add -g pm2 bunyan'
    echo "  Successfully installed PM2 and Bunyan!"

    echo "Successfully created NodeJS user '$newUser'!"
done