FROM debian:oldstable

RUN apt-get update -y && apt-get upgrade -y \
	&& apt-get install -y php7.4-fpm php7.4 wget curl \
	&& apt-get install -y php-cli php-mysql php-mbstring php-xml sendmail


RUN mkdir /run/php


RUN wget https://wordpress.org/latest.tar.gz \ 
	&& tar -xvf latest.tar.gz \
	&& mkdir -p /var/www/html/ \
	&& mv wordpress/* /var/www/html/ \
	&& chown -R www-data:www-data /var/www/html \
	&& rm -r /wordpress latest.tar.gz

COPY ./requirements/wordpress/conf/wp-config.php /var/www/html/wp-config.php
COPY ./requirements/wordpress/conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# COPY ./requirements/wordpress/conf/php.ini /etc/php/7.4/fpm/php.ini

# # COPY ./requirements/wordpress/conf/my.cnf /etc/
# COPY ./conf/wp-config.php /var/www/html
# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# COPY ./conf/wp-config.php /var/www/html
# COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
# # VOLUME ["/var/lib/mysql"]
EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]