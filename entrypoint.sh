#!/bin/bash
set -e

if [ "$1" = "tomcat-start" ]; then
    if [ "$MANAGER_ALLOW_REMOTE" = "true" ]; then
	sed -i '19 s/^/<!--/' $TOMCAT_MANAGER/*manager/META-INF/context.xml; sed -i '20 s/$/ -->/' $TOMCAT_MANAGER/*manager/META-INF/context.xml	
    fi
    sh $CATALINA_HOME/bin/catalina.sh run
fi


exec "$@"
