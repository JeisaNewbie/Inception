FROM alpine:3.17

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && apk upgrade \
    && apk add php-fpm php82 fcgi php82-cgi wget curl \
	&& apk add php-cli php-mysqli php-mbstring php-xml \
	&& apk add mariadb-client \
	&& rm -rf /var/cache/apk/*

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xvf latest.tar.gz

WORKDIR /var/www/html

RUN mv /wordpress/* /var/www/html \
    && adduser -S -D -u 82 -s /sbin/nologin -h /var/www -G www-data www-data \
	&& chown -R www-data:www-data /var/www/html \
	&& mv ./wp-config-sample.php wp-config.php \
    && rm -r /wordpress /latest.tar.gz

WORKDIR /
COPY ./requirements/wordpress/conf/wp-config.php /var/www/html
COPY ./requirements/wordpress/conf/www.conf /etc/php81/php-fpm.d/
COPY ./requirements/wordpress/conf/my.cnf /etc/
# COPY ./conf/www.conf /etc/php81/php-fpm.d/
# COPY ./conf/wp-config.php ./

VOLUME ["/var/lib/mysql"]

EXPOSE 9000