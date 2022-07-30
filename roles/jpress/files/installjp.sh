#!/bin/bash
#tomcat install shell scripts
echo "$(date '+%D %T') tomcat 部署apache..." >>/root/install.log

tar xf /files/tomcat/apache-maven-3.3.9-bin.tar.gz -C /usr/local/
ln -s /usr/local/apache-maven-3.3.9 /usr/local/maven
sed -i.ori '$a export MAVEN_HOME=/usr/local/maven \nexport PATH="$MAVEN_HOME/bin:$PATH"' /etc/profile &>/dev/null 
#source /etc/profile
echo "$(date '+%D %T') tomcat 部署jp..." >>/root/install.log

#mkdir -p /data/www/www/ROOT/
rm -rf /usr/local/tomcat/webapps/*
#mv /files/tomcat/jpress-web-newest.war /data/www/www/ROOT/
mv /files/tomcat/jpress-web-newest.war /usr/local/tomcat/webapps
#/usr/local/jdk/bin/jar xf /data/www/www/ROOT/
#/usr/local/jdk/bin/jar xf /data/www/www/ROOT/jpress-web-newest.war


echo "$(date '+%D %T') jp 部署完成..." >>/root/install.log