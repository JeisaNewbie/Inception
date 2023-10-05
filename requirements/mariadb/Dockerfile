FROM alpine:3.17

RUN apk update && apk upgrade \
    && apk add mariadb mariadb-client curl \
	&& apk add openrc && apk update && apk upgrade \
	&& rm -rf /var/cache/apk/*

COPY ./requirements/mariadb/conf/my.cnf /etc/
COPY ./requirements/mariadb/conf/mariadb-server.cnf /etc/my.cnf.d/
COPY ./requirements/mariadb/tools/* .
# COPY ./conf/my.cnf /etc/
# COPY ./tools/* .
VOLUME ["/var/lib/mysql"]

RUN chmod +x start_mariadb.sh
RUN chmod 644 /etc/my.cnf

EXPOSE 3306
ENTRYPOINT sh start_mariadb.sh