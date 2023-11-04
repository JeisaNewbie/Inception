#!/bin/bash

if [ ! -e "/var/lib/mysql/.init_complete" ]; then
	mysq_install_db --user=mysql --datadir=/var/lib/mysql

	gosu mysql /usr/sbin/mysql --skip-grant-tables --skip-networking --pid-file=/var/run/mysqld/mysqld.pid &

	for i in {30..0}; do
		if echo 'SELECT 1' | mysql &> /dev/null; then
			break
		fi
		sleep 1
	done

	if [ "$i" = 0 ]; then
		echo >&2 'MariaDB init failed'
		exit 1
	fi

	mysql -e "UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='$WORDPRESS_DB_USER';"
	mysql -e "FLUSH PRIVILEGES;"


	kill -TERM $(cat /var/run/mysqld/mysqld.pid)
	sleep 5

	if [ -f /var/run/mysqld/mysqld.pid ]; then
		rm -f /var/run/mysqld/mysqld.pid
	fi


	gosu mysql /usr/sbin/mysqld --skip-networking --pid-file=/var/run/mysqld/mysqld.pid &  


	for i in {30..0}; do
		if echo 'SELECT 1' | mysql -u root -p$MYSQL_ROOT_PASSWORD &> /dev/null; then
			break
		fi
		sleep 1
	done

	mysql -u $WORDPRESS_DB_USER -p$MYSQL_ROOT_PASSWORD -e"CREATE DATABASE $WORDPRESS_DB_NAME;"
	mysql -u $WORDPRESS_DB_USER -p$MYSQL_ROOT_PASSWORD -e"CREATE USER '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';"
	mysql -u $WORDPRESS_DB_USER -p$MYSQL_ROOT_PASSWORD -e"GRANT ALL privileges ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'%' WITH GRANT OPTION;"

		kill -TERM $(cat /var/run/mysqld/mysqld.pid)
		sleep 5
	touch /var/lib/mysql/.init_complete
fi

exec gosu mysql /usr/sbin/mysqld