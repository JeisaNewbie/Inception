FROM debian:oldstable

WORKDIR /var/www/html

RUN set -eux

RUN apt update && apt install -y curl php-fpm php-gd php-mysql php-json \
	php-curl php-mbstring php-intl php-imagick php-xml php-zip mariadb-client 

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

COPY ./tools/wordpress.sh /root/entrypoint.sh

RUN chmod +x wp-cli.phar /root/entrypoint.sh && mv wp-cli.phar /bin/wp

COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /
ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]