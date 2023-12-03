FROM debian:oldstable

RUN apt-get update -y \ 
	&& apt-get upgrade -y \
    && apt-get install -y curl mariadb-server procps gosu

COPY ./requirements/mariadb/conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./requirements/mariadb/conf/my.cnf /etc/mysql/my.cnf
COPY ./requirements/mariadb/tools/* ./

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
RUN chmod +x start_mariadb.sh

ENTRYPOINT ["/bin/bash", "start_mariadb.sh"]