#!/bin/bash
#php install shell scripts
test -d /media/cdrom || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom &>/dev/null

echo "php安装openssl等" >>/root/install.log
yum -y install openssl-devel &>/dev/null
yum -y install zlib-devel libxml2-devel libjpeg-devel libjpeg-turbo-devel libiconv-devel &>/dev/null
yum -y install freetype-devel libpng-devel gd libcurl-devel libxslt-devel &>/dev/null

echo "安装libiconv 等" >>/root/install.log
test -d /files/php || exit 3
cd /files/php || exit 3
tar xf libiconv-1.14.tar.gz -C /usr/src/
cd /usr/src/libiconv-1.14/ || exit
./configure --prefix=/usr/local/libiconv && make && make install &>/dev/null

echo "php创建repo源" >>/root/install.log
yum -y install wget
cd /etc/yum.repos.d/ || exit
mkdir bak
mv /etc/yum.repos.d/* /etc/yum.repos.d/bak/
wget http://files.tttidc.com/centos6/epel-6.repo &>/dev/null
yum clean all &>/dev/null
yum makecache &>/dev/null

echo "php安装安装mcrypt等" >>/root/install.log
yum -y install libmcrypt-devel &>/dev/null #安装libmcrypt库
yum -y install mhash &>/dev/null           # 安装mhash加密扩展库
yum -y install mcrypt &>/dev/null

#--------------------------------------------------------
echo "php安装php配置文件" >>/root/install.log
cd /files/php || exit
tar xf php-5.3.28.tar.gz -C /usr/src/
cd /usr/src/php-5.3.28/ || exit
useradd -s /shin/nologin -M www #创建用户
./configure --prefix=/usr/local/php5.3.28 --with-mysql=mysqlnd --with-iconv-dir=/usr/local/libiconv --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fpm --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --enable-short-tags --enable-zend-multibyte --enable-static --with-xsl --with-fpm-user=www --with-fpm-group=www --enable-ftp &>/dev/null
make &>/dev/null
make install &>/dev/null

echo "php复制配置文件" >>/root/install.log
ln -s /usr/local/php5.3.28/ /usr/local/php
cd /usr/src/php-5.3.28 || exit
cp php.ini-production /usr/local/php/lib/php.ini #复制一下配置
cd /usr/local/php/etc/ || exit
cp php-fpm.conf.default php-fpm.conf

echo "php恢复原yum" >>/root/install.log
#下一步需要在php-fpm.conf添加本地ip
mkdir /etc/yum.repos.d/epel
mv /etc/yum.repos.d/epel-6* /etc/yum.repos.d/epel
mv /etc/yum.repos.d/bak/* /etc/yum.repos.d/
echo "php 完成" >>/root/install.log
