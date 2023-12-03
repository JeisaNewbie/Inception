#!/bin/bash

cd /var/www/html

wp core download --allow-root
echo "----- wordpress downloaded -----"

set -e

wp core install --allow-root --url=jhwang2.42.fr --title=jehwang \
		--admin_user=jhwang2 --admin_password=jhwang242 \
		--admin_email=test@test.com --skip-email
echo "----- wordpress installed -----"
chown -R www-data:www-data /var/www/html

echo "----- change owner -----"

set +e

service php7.4-fpm stop

service php7.4-fpm start

service php7.4-fpm stop

echo "----- php restart -----"

# CMD 실행
exec "$@"