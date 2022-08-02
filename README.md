# ansible 安装

说明：本安装是基于centos7系统

## 一 安装包
位置：/package
内容：
### mysql/nginx/php/wordpress/tomcat
libiconv-1.14.tar.gz 
mysql-5.5.32-linux2.6-x86_64.tar.gz  
nginx-1.10.2.tar.gz  
php-5.3.28.tar.gz
wordpress-4.7.4-zh_CN.tar.gz
jdk-8u60-linux-x64.tar.gz
apache-tomcat-8.0.27.tar.gz

### jpress
apache-maven-3.3.9-bin.tar.gz
jpress-web-newest.war 
### lb
https://www.keepalived.org/download.html 
keepalived-2.0.10.tar.gz



## 二 hosts主机：
[nginx]   #开两个网段200和100

an-nginx01      
an-nginx02     

[tomcat]
#开两个网段200和100
an-tomcat01   地址：192.168.200.189:8080   # 做免秘钥登录

[mysql]
an-mysql

[lb]        #高可用+负载均衡
an-lb01
an-lb02


# 三 角色备注
## roles/nginx
nginx.conf 自动添加：include extra/www.conf;并单独创建了extra目录和www.conf文件
网页根目录在默认html里

## roles/php
## roles/lb
反向代理，keepalived高可用


