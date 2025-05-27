#!/bin/sh

echo "Entrypoint: Setting Flarum directory permissions..."
chown -R www-data:www-data /var/www/flarum

if [ -d "/var/www/flarum/storage" ]; then
	chmod -R 775 /var/www/flarum/storage
fi
if [ -d "/var/www/flarum/public/assets" ]; then
	chmod -R 775 /var/www/flarum/public/assets
fi

chmod 775 /var/www/flarum 

echo "Entrypoint: Permissions set. Executing CMD: $@"

exec "$@"