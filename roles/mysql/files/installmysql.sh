#!/bin/bash
#mysql install shell scripts
test -d /media/cdrom || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom &>/dev/null

groupadd mysql
useradd -s /sbin/nologin -g mysql -M mysql
cd /files/mysql || exit
tar xf mysql-5.5.32-linux2.6-x86_64.tar.gz -C /usr/local/
cd /usr/local/ || exit
mv mysql-5.5.32-linux2.6-x86_64/ mysql-5.5.32       
ln -s mysql-5.5.32/ mysql         
cd /usr/local/mysql || exit
/bin/cp support-files/my-small.cnf /etc/my.cnf   
mkdir -p /usr/local/mysql/data      #建立MySQL数据文件目录
chown -R mysql.mysql /usr/local/mysql  #授权mysql用户管理MySQL的安装目录
yum -y install libaio &>/dev/null    #光盘源安装依赖包，否则下一步的编译会报错
/usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql     #初始化MySQL数据库文件，
cd /usr/local/mysql || exit
cp support-files/mysql.server /etc/init.d/mysqld   
chmod +x /etc/init.d/mysqld
/etc/init.d/mysqld start              
systemctl enable mysqld     # 设置开机启动项
ln -s /usr/local/mysql/bin/* /usr/local/bin/   
