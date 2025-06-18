#!/bin/sh

# As the root user, set ownership ONLY on the directories that Flarum needs to write to.
# This avoids "Operation not permitted" errors on mounted volumes like `packages`.
chown -R www-data:www-data /var/www/flarum/storage
chown -R www-data:www-data /var/www/flarum/public/assets

echo "Entrypoint: Permissions set. Executing CMD: $@"

# Execute the main command (php-fpm)
exec "$@"