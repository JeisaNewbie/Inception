rc default
/etc/init.d/mariadb setup
rc-service mariadb start
mysql -u root mysql < create_db
# mysql -u root mydb < jhwang2_db.sql
rc-service mariadb stop
/usr/bin/mysqld_safe
