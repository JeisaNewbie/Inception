FROM debian:oldstable

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y nginx openssl vim

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=42Seoul/CN=jhwang2.42.fr"

COPY ./conf/default /etc/nginx/sites-available/default
COPY ./conf/fastcgi_params /etc/nginx/fastcgi_params
CMD ["nginx", "-g", "daemon off;"]