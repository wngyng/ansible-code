#!/bin/bash
#nginx install shell scripts
echo "nginx开始安装" >>/root/install.log
test -d /media/cdrom || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom &>/dev/null
echo "nginx挂载完成" >>/root/install.log

yum -y install gcc gcc-c++ make pcre pcre-devel zlib zlib-devel openssl openssl-devel &>/dev/null
echo "nginx环境包完成" >>/root/install.log

test -d /files/nginx || exit 3
cd /files/nginx || exit 3
tar xf nginx-1.10.2.tar.gz -C /usr/src/
cd /usr/src/nginx-1.10.2/ || exit 3
./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-http_stub_status_module &>/dev/null
echo "nginx初始化完成" >>/root/install.log

make &>/dev/null
make install &>/dev/null
echo "nginx编译完成" >>/root/install.log

mkdir -p /usr/local/nginx/conf/extra
mkdir -p /var/www/html/blogcom
mkdir -p /www/html/blogcom
chown -R www.www /www
echo "html php" >/www/index.php #创建测试文件
/usr/local/nginx/sbin/nginx
echo "nginx启动完成" >>/root/install.log
exit 0
