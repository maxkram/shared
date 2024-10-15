#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Preparing WordPress..."

	wp config create --allow-root					\
					--dbname=$MDB_NAME				\
					--dbuser=$MDB_USER				\
					--dbpass=$MDB_PWD				\
					--dbhost=$MDB_HOST				\
					--path='/var/www/html'

	wp core install --url=$WP_URL					\
					--title=$WP_TITLE				\
					--admin_user=$WP_ADMIN			\
					--admin_password=$WP_ADMIN_PWD	\
					--admin_email=$WP_ADMIN_EMAIL	\
					--skip-email					\
					--allow-root

	wp user create	$WP_USER $WP_USER_EMAIL			\
					--role=subscriber				\
					--user_pass=$WP_USER_PWD		\
					--allow-root

	wp option update home 'https://mkramer.42.fr' --allow-root
	wp option update siteurl 'https://mkramer.42.fr' --allow-root
else
	echo "WordPress is already ready."
fi

exec "$@"
