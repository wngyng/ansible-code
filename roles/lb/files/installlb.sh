#!/bin/bash
#nginx install shell scripts
echo "$(date '+%D %T') nginx 开始安装" >>/root/install.log
test -d /media/cdrom || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom &>/dev/null
echo "$(date '+%D %T') nginx 挂载完成" >>/root/install.log

yum -y install openssl openssl-devel pcre pcre-devel &>/dev/null
echo "$(date '+%D %T') nginx 环境安装包完成" >>/root/install.log

test -d /files/nginx || exit 3
tar xf /files/nginx/nginx-1.10.2.tar.gz -C /usr/src/
useradd -M -s /sbin/nologin nginx
cd /usr/src/nginx-1.10.2/ || exit 3
./configure --user=nginx --group=nginx --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module &>/dev/null
echo "$(date '+%D %T') nginx预配置完成" >>/root/install.log

make &>/dev/null
make install &>/dev/null
ln -s /usr/local/nginx/sbin/* /usr/local/sbin/ &>/dev/null
echo "$(date '+%D %T') nginx make install完成" >>/root/install.log

# mkdir -p /usr/local/nginx/conf/extra
 /usr/local/nginx/sbin/nginx #开启
# echo "nginx启动完成" >>/root/install.log
# exit 0
