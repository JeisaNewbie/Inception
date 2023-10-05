!/bin/sh

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt
chmod 600 etc/ssl/certs/server.crt etc/ssl/private/server_pkey.pem