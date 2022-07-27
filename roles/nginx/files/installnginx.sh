#!/bin/bash
#nginx install shell scripts
test -d /media/cdrom || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom &>/dev/null
yum -y install gcc gcc-c++ make pcre pcre-devel zlib zlib-devel openssl openssl-devel &>/dev/null
test -d /files/nginx || exit 3
cd /files/nginx || exit 3
tar xf nginx-1.10.2.tar.gz -C /usr/src/
cd /usr/src/nginx-1.10.2/ || exit 3
./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-http_stub_status_module &>/dev/null
make &>/dev/null
make install &>/dev/null
mkdir -p /usr/local/nginx/conf/extra
mkdir -p /var/www/html/blogcom
/usr/local/nginx/sbin/nginx
exit 0
