FROM alpine:3.17

RUN apk update && apk upgrade
    # && apk add nginx openssl vim \
	# && apk add openrc

# RUN adduser -D -g 'www' www && mkdir -p /www \
# 	&& chown -R www:www /var/lib/nginx && chown -R www:www /www

# RUN	mkdir -p /run/nginx

# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt
# RUN chown -R www-data:www-data /var/www/html

# COPY ./requirements/nginx/conf/default.cnf /etc/nginx/http.d/
# COPY ./requirements/nginx/tools/nginx.sh .
# COPY ./conf/default.conf /etc/nginx/http.d/
# COPY ./tools/nginx.sh .
EXPOSE 8080
# ENTRYPOINT sh nginx.sh