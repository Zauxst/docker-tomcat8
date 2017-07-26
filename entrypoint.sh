#!/bin/bash
set -e

if [ "$1" = "start" ]; then
    #Verify if manager is active
    if [[ "$MANAGER_ALLOW_REMOTE" = "true" && -e /container_first_time_run ]]; then
	sed -i '19 s/^/<!--/' $CATALINA_HOME/webapps/*manager/META-INF/context.xml; sed -i '20 s/$/ -->/' $CATALINA_HOME/webapps/*manager/META-INF/context.xml	
	sed -i "s/MANAGER_ADMIN_USER/$MANAGER_USER/g" $CATALINA_HOME/conf/tomcat-users.xml; sed -i "s/MANAGER_ADMIN_PASSWORD/$MANAGER_PASSWORD/g" $CATALINA_HOME/conf/tomcat-users.xml;
	#Else echo debug message
	else
		echo "Skipping MANAGER ENV commands";
    fi
    
    # IF statement for further case analysis, if different commands are runed into docker exec
    if [ "$1" = "start" ]; then
    touch /container_first_time_run
    sh $CATALINA_HOME/bin/catalina.sh run
    fi
fi

exec "$@"

