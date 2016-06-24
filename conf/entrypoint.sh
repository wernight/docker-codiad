#!/bin/sh

# Install Codiad if not already installed.
if [ ! -d '/code/.git' ]; then
    cp -r /default-code/* /code
    chmod go+w \
        /code/config.php \
        /code/workspace \
        /code/plugins \
        /code/themes \
        /code/data
fi

exec "$@"
