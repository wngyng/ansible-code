#!/bin/bash
#mysql install shell scripts
test -d /media/cdrom || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom &>/dev/null
echo "挂在完成" >>/root/install.log

groupadd mysql
useradd -s /sbin/nologin -g mysql -M mysql
echo "创建账户完成" >>/root/install.log
cd /files/mysql || exit
tar xf mysql-5.5.32-linux2.6-x86_64.tar.gz -C /usr/local/
cd /usr/local/ || exit
mv mysql-5.5.32-linux2.6-x86_64/ mysql-5.5.32
ln -s mysql-5.5.32/ mysql
cd /usr/local/mysql || exit
/bin/cp support-files/my-small.cnf /etc/my.cnf
mkdir -p /usr/local/mysql/data
chown -R mysql.mysql /usr/local/mysql
echo "安装前准备完成" >>/root/install.log

yum -y install libaio &>/dev/null
echo "安装libaio完成" >>/root/install.log
/usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql &>/dev/null
echo "初始化完成" >>/root/install.log
cd /usr/local/mysql || exit
cp support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
/etc/init.d/mysqld start
systemctl enable mysqld # 设置开机启动项
ln -s /usr/local/mysql/bin/* /usr/local/bin/
echo "全部完成" >>/root/install.log
