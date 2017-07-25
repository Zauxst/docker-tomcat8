#!/bin/bash
set -e

if [ "$1" = "start" ]; then
    #Verify if manager is active
    if [ "$MANAGER_ALLOW_REMOTE" = "true" ]; then
	sed -i '19 s/^/<!--/' $TOMCAT_MANAGER/*manager/META-INF/context.xml; sed -i '20 s/$/ -->/' $TOMCAT_MANAGER/*manager/META-INF/context.xml	
	sed -i "s/MANAGER_REMOTE_USER/$MANAGER_USER/g" $CATALINA_HOME/conf/tomcat-users.xml; sed -i "s/MANAGER_REMOTE_PASSWORD/$MANAGER_PASSWORD/g" $CATALINA_HOME/conf/tomcat-users.xml;
	#Else echo debug message
	else
		echo "MANAGER_ALLOW_REMOTE=$MANAGER_ALLOW_REMOTE which is not \"true\" ";
    fi



    sh $CATALINA_HOME/bin/catalina.sh run
fi


exec "$@"
