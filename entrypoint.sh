#!/bin/bash
set -e

if [ "$1" = "start" ]; then
    #Verify if manager is active
    if [ "$MANAGER_ALLOW_REMOTE" = "true" ]; then
	sed -i '19 s/^/<!--/' $TOMCAT_WEBAPPS/*manager/META-INF/context.xml; sed -i '20 s/$/ -->/' $TOMCAT_WEBAPPS/*manager/META-INF/context.xml	
	sed -i "s/MANAGER_ADMIN_USER/$MANAGER_USER/g" $CATALINA_HOME/conf/tomcat-users.xml; sed -i "9 s/MANAGER_ADMIN_PASSOWRD/$MANAGER_PASSWORD/g" $CATALINA_HOME/conf/tomcat-users.xml;

		if [ "$TOMCAT_MANAGER" -ne "$TOMCAT_WEBAPPS" ]; then
			echo "<Context path=\"/host-manager\" " >> $CATALINA_HOME/conf/Catalina/localhost/host-manager.xml
			echo "        docBase=\"TOMCAT_ADMIN_DIR\" " >> $CATALINA_HOME/conf/Catalina/localhost/host-manager.xml
			echo "        antiResourceLocking=\"false\" privileged=\"true\" /> " >> $CATALINA_HOME/conf/Catalina/localhost/host-manager.xml


			echo "<Context path=\"/manager\" " >> $CATALINA_HOME/conf/Catalina/localhost/manager.xml
			echo "        docBase=\"TOMCAT_ADMIN_DIR\" " >> $CATALINA_HOME/conf/Catalina/localhost/manager.xml
			echo "        antiResourceLocking=\"false\" privileged=\"true\" /> " >> $CATALINA_HOME/conf/Catalina/localhost/manager.xml

		        sed -i "s@TOMCAT_ADMIN_DIR@$TOMCAT_MANAGER/@g" $CATALINA_HOME/conf/Catalina/localhost/*

			mv $TOMCAT_WEBAPPS/*manager $TOMCAT_MANAGER/
		fi


	#Else echo debug message
	else
		echo "MANAGER_ALLOW_REMOTE=$MANAGER_ALLOW_REMOTE which is not \"true\" ";

    sh $CATALINA_HOME/bin/catalina.sh run
fi

exec "$@"

