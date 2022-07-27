#!/bin/bash
#php install shell scripts
test -d /media/cdrom || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom &>/dev/null
echo "挂在完成" >>/root/php.log
#安装环境
yum -y install gcc gcc-c++ make pcre pcre-devel zlib openssl openssl-devel zlib-devel &>/dev/null
yum -y install zlib-devel libxml2-devel libjpeg-devel libjpeg-turbo-devel libiconv-devel &>/dev/null
yum -y install freetype-devel libpng-devel gd libcurl-devel libxslt-devel &>/dev/null
echo "安装gcc等完成" >>/root/php.log

test -d /files/php || exit 3
cd /files/php || exit 3
tar xf libiconv-1.14.tar.gz -C /usr/src/
cd /usr/src/libiconv-1.14/ || exit
./configure --prefix=/usr/local/libiconv && make && make install &>/dev/null
echo "安装libiconv 完成" >>/root/php.log

#创建repo源
yum -y install wget
cd /etc/yum.repos.d/ || exit
mkdir bak
mv /etc/yum.repos.d/* /etc/yum.repos.d/bak/
wget http://files.tttidc.com/centos6/epel-6.repo
yum clean all &>/dev/null
yum makecache &>/dev/null
echo "安装epel-6 完成" >>/root/php.log
#安装软件
yum -y install libmcrypt-devel &>/dev/null #安装libmcrypt库
yum -y install mhash &>/dev/null           # 安装mhash加密扩展库
yum -y install mcrypt &>/dev/null
echo "安装mcrypt等 完成" >>/root/php.log

cd /files/php || exit
tar xf php-5.3.28.tar.gz -C /usr/src/
cd /usr/src/php-5.3.28/ || exit
useradd -s /shin/nologin -M www #创建用户
./configure --prefix=/usr/local/php5.3.28 --with-mysql=mysqlnd --with-jpeg-dir --with-iconv-dir=/usr/local/libiconv --with-freetype-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --disable-rpath --enable-safe-mode --enable-bcmath --enable-shmop --enable-inline-optimization --with-curl --with-curlwrappers --enable-fpm --enable-mbstring --with-mcrypt --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --with-xmlrpc --enable-zip --enable-soap --enable-zend-multibyte --enable-static --with-xsl --with-fpm-group=www --enable-ftp --enable-sysvsem --enable-mbregex --with-gd --enable-sockets --enable-short-tags --with-fpm-user=www --enable-xml &>/dev/null
make && make install &>/dev/null
echo "安装 php 完成" >>/root/php.log
ln -s /usr/local/php5.3.28/ /usr/local/php
cd /usr/src/php-5.3.28 || exit
cp php.ini-production /usr/local/php/lib/php.ini #复制一下配置
cd /usr/local/php/etc/ || exit
cp php-fpm.conf.default php-fpm.conf
echo "安装复制配置文件 完成" >>/root/php.log
#下一步需要在php-fpm.conf添加本地ip

#恢复原yum
mkdir /etc/yum.repos.d/epel
mv /etc/yum.repos.d/epel-6* /etc/yum.repos.d/epel
mv /etc/yum.repos.d/bak/* /etc/yum.repos.d/
echo "恢复 yum源 完成" >>/root/php.log

