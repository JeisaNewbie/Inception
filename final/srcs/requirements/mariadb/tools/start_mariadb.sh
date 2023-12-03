#!/bin/bash

if [ ! -e "/var/lib/mysql/init_db" ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	gosu mysql /usr/sbin/mysqld --skip-grant-tables --skip-networking --pid-file=/var/run/mysqld/mysqld.pid &

	for i in {30..0}; do
      if echo 'SELECT 1' | mysql &> /dev/null; then
          break
      fi
      sleep 1
  	done
	mysql -e "UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root';"
	mysql -e "FLUSH PRIVILEGES;"


	kill -TERM $(cat /var/run/mysqld/mysqld.pid)
	sleep 5

	if [ -f /var/run/mysqld/mysqld.pid ]; then
		rm -f /var/run/mysqld/mysqld.pid
	fi


	gosu mysql /usr/sbin/mysqld --skip-networking --pid-file=/var/run/mysqld/mysqld.pid &  


	for i in {30..0}; do
		if echo 'SELECT 1' | mysql -u $WORDPRESS_DB_USER -p$MYSQL_ROOT_PASSWORD &> /dev/null; then
			break
		fi
		sleep 1
	done
	mysql -u root -p$MYSQL_ROOT_PASSWORD -e"CREATE DATABASE $WORDPRESS_DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
	mysql -u root -p$MYSQL_ROOT_PASSWORD -e"CREATE USER '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';"
	mysql -u root -p$MYSQL_ROOT_PASSWORD -e"GRANT ALL privileges ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'%' WITH GRANT OPTION;"

		kill -TERM $(cat /var/run/mysqld/mysqld.pid)
		sleep 5
	touch /var/lib/mysql/init_db
fi

exec gosu mysql /usr/sbin/mysqld