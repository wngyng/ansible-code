#!/bin/bash
#wordpress install shell scripts
mysql -uroot -p123123                                       #登录mysql
create database wordpress;                                  #创建一个数据库，名字为wordpress
show databases like 'wordpress';                          # 查看
grant all on wordpress.* to wordpress@'localhost' identified by '123123';    
#创建一个专用的WordPress blog管理用户，#localhost为客户端地址
flush privileges;                                                     #刷新权限，使得创建用户生效
show grants for wordpress@'localhost';               #查看用户对应权限
select user,host,password from mysql.user;      #查看数据库里创建wordpress用户
quit