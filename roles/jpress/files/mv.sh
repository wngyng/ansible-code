#!/bin/bash
while true; do
    if [ -d "/usr/local/tomcat/webapps/jpress-web-newest" ]; then
        mv /usr/local/tomcat/webapps/jpress-web-newest /usr/local/tomcat/webapps/ROOT
        exit 0
    elif [ "$h" -gt 3 ]; then
        exit 100
    else
        sleep 3s
        ((h++))
    fi
done
