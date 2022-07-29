#!/bin/bash
#tomcat install shell scripts
echo "$(date '+%D %T') tomcat 部署java环境jdk..." >>/root/install.log
test -d /media/cdrom || mkdir -p /media/cdrom
mount /dev/sr0 /media/cdrom &>/dev/null

tar xf /files/tomcat/jdk-8u60-linux-x64.tar.gz -C /usr/local/
ln -s /usr/local/jdk1.8.0_60 /usr/local/jdk
#ln -s /usr/java/jdk1.8.0_341-amd64 /usr/local/jdk
sed -i.ori '$a export JAVA_HOME=/usr/local/jdk\nexport PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH\nexport CLASSPATH=.$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar' /etc/profile &>/dev/null #配置java环境变量

echo "$(date '+%D %T') tomcat 开始安装" >>/root/install.log
tar xf /files/tomcat/apache-tomcat-8.0.27.tar.gz -C /usr/local/
ln -s /usr/local/apache-tomcat-8.0.27/ /usr/local/tomcat
echo 'export TOMCAT_HOME=/usr/local/tomcat' >>/etc/profile #配置tomcat环境变量
chown -R root.root /usr/local/jdk /usr/local/tomcat/
echo "$(date '+%D %T') tomcat 安装完成" >>/root/install.log
