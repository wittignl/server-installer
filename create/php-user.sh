#!/bin/bash

# Create users
/bin/bash ./user.sh "$@"

# Iterate through each user and install the tooling for them.
for newUser in "$@"
do
    echo "Creating PHP user '$newUser'..."

    # Install Composer
    echo "  Installing Composer..."

    ## Download installer signature
    EXPECTED_CHECKSUM="$( sudo -H -u "$newUser" bash -c 'php -r "copy(\"https://composer.github.io/installer.sig\", \"php://stdout\");"' )"

    ## Download installer
    sudo -H -u "$newUser" bash -c 'php -r "copy(\"https://getcomposer.org/installer\", \"composer-setup.php\");"'
    ACTUAL_CHECKSUM="$(sudo -H -u "$newUser" bash -c 'php -r "echo hash_file(\"sha384\", \"composer-setup.php\");"')"

    ## Compare checksums
    if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
    then
        >&2 echo 'ERROR: Invalid installer checksum'
        sudo -H -u "$newUser" bash -c 'rm composer-setup.php'
        continue
    fi

    ## Run Composer Installer
    sudo -H -u "$newUser" bash -c 'php composer-setup.php --quiet'

    ## Remove installer
    sudo -H -u "$newUser" bash -c 'rm composer-setup.php'

    ## Move installer to user bin
    sudo -H -u "$newUser" bash -c 'mkdir ~/bin'
    sudo -H -u "$newUser" bash -c 'mv composer.phar ~/bin/composer'

    echo "  Successfully installed Composer!"

    echo "Successfully created PHP user '$newUser'!"
done