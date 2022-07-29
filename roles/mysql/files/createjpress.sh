#!/bin/bash
#jpress install shell scripts

mysql -uroot -p123123 -e 'create database jpress;'
mysql -uroot -p123123 -e "grant all on jpress.* to jpress@'192.168.100.%' identified by '123123';"
mysql -uroot -p123123 -e 'flush privileges;'
mysql -uroot -p123123 -e 'select user,host,password from mysql.user;'
