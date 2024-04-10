#!/bin/bash

for newUser in "$@"
do
    # Create new User
    useradd -m -s /bin/bash $newUser

    # Install NVM
    sudo -H -u $newUser bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'

    # Install NodeJS
    sudo -H -u $newUser bash -c 'nvm use node'

    # Install and Setup PNPM
    sudo -H -u $newUser bash -c 'corepack enable && corepack use --activate pnpm@latest'

    # Install PM2 and Bunyan
    sudo -H -u $newUser bash -c 'pnpm add -g pm2 bunyan'
done
