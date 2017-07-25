#!/bin/bash
set -e

if [ "$1" = "start" ]; then
    #Verify if manager is active
    if [ "$MANAGER_ALLOW_REMOTE" = "true" ]; then
	sed -i '19 s/^/<!--/' $CATALINA_HOME/webapps/*manager/META-INF/context.xml; sed -i '20 s/$/ -->/' $CATALINA_HOME/webapps/*manager/META-INF/context.xml	
	sed -i "s/MANAGER_ADMIN_USER/$MANAGER_USER/g" $CATALINA_HOME/conf/tomcat-users.xml; sed -i "9 s/MANAGER_ADMIN_PASSOWRD/$MANAGER_PASSWORD/g" $CATALINA_HOME/conf/tomcat-users.xml;

		if [ "$TOMCAT_MANAGER" != "/opt/tomcat/webapps" ] ; then
			mkdir -p $TOMCAT_MANAGER
			mkdir -p $CATALINA_HOME/conf/Catalina/localhost
		touch $CATALINA_HOME/conf/Catalina/localhost/host-manager.xml
		touch $CATALINA_HOME/conf/Catalina/localhost/manager.xml
echo "<Context path=\"/host-manager\" 
        docBase=\"TOMCAT_ADMIN_DIR\"/host-manager
        antiResourceLocking=\"false\" privileged=\"true\" /> " >> $CATALINA_HOME/conf/Catalina/localhost/host-manager.xml
echo "<Context path=\"/manager\" 
        docBase=\"TOMCAT_ADMIN_DIR\"/manager
        antiResourceLocking=\"false\" privileged=\"true\" /> " >> $CATALINA_HOME/conf/Catalina/localhost/manager.xml

		        sed -i "s@TOMCAT_ADMIN_DIR@$TOMCAT_MANAGER/@g" $CATALINA_HOME/conf/Catalina/localhost/*xml

			#mv $CATALINA_HOME/webapps/host-manager $TOMCAT_MANAGER/
			mv $CATALINA_HOME/webapps/*manager $TOMCAT_MANAGER/
		fi


	#Else echo debug message
	else
		echo "MANAGER_ALLOW_REMOTE=$MANAGER_ALLOW_REMOTE which is not \"true\" ";
    fi
    sh $CATALINA_HOME/bin/catalina.sh run
fi

exec "$@"

