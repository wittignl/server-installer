# Wittig Server Installer
This collection of shell scripts has been designed to simplify the installation of a Wittig server on a fresh Ubuntu 22.04 LTS (Jammy Jellyfish) server.
Newer ubuntu versions may also work.

## Node server (Recommended)
```bash
./setup-node-server.sh (<username1> <username2> <username3>)
```
Users can automatically be created by providing a list of usernames as arguments.
This is optional and can also be done either manually or with the provided scripts at a later time.

### Additional users
Additional users for the server can be created using the following command:

#### With NodeJS, PNPM and PM2 enabled
```bash
./create/node-user.sh <username1> <username2> <username3>
```

#### Regular unix user
```bash
./create/user.sh <username1> <username2> <username3>
```

## PHP Server (Legacy Support)
```bash
./setup-php-server.sh (<username1> <username2> <username3>)
```
Users can automatically be created by providing a list of usernames as arguments.
This is optional and can also be done either manually or with the provided scripts at a later time.

### Additional users
Additional users for the server can be created using the following command:

#### With PHP enabled
```bash
./create/php-user.sh <username1> <username2> <username3>
```

#### Regular unix user
```bash
./create/user.sh <username1> <username2> <username3>
```