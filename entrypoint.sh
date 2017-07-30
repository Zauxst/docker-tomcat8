#!/bin/bash
set -e
chown -R ${USER}:${GROUP} $CATALINA_HOME

if [ ! -e /container_first_time_run ]; then
	
	#Debug msj for env v0.4.5
	echo "Image is running in $DOCKER_IMAGE_VALUE mode";
	echo "MANAGER_ALLOW_REMOTE=$MANAGER_ALLOW_REMOTE";
	echo "MANAGER_USER=$MANAGER_USER";
	echo "MANAGER_PASSWORD=$MANAGER_PASSWORD";

	else
		echo "CONTAINER ALREADY RUNNED on = $(tail ${CATALINA_HOME}/container_first_time_run)";
fi

if [ "$1" = "start" ];then
	# PROD default start
	if [[ "$DOCKER_IMAGE_VALUE" = "prod" || "$DOCKER_IMAGE_VALUE" = "production" ]]; then
	# Setting user permissions for security
		
		sh $CATALINA_HOME/bin/catalina.sh run
		echo "Starting script on: $(date +%F-%R)" >> ${CATALINA_HOME}/container_first_time_run
	fi
	# DEV start


	if [[ "$DOCKER_IMAGE_VALUE" = "dev" || "$DOCKER_IMAGE_VALUE" = "developement" ]]; then
	# Verify if manager is active
		if [[ "$MANAGER_ALLOW_REMOTE" = "true" && ! -e /container_first_time_run ]]; then
			echo "Setting manager USERNAME and PASSWORD"
			sed -i '19 s/^/<!--/' $CATALINA_HOME/webapps/*manager/META-INF/context.xml; sed -i '20 s/$/ -->/' $CATALINA_HOME/webapps/*manager/META-INF/context.xml	
			sed -i "s/MANAGER_ADMIN_USER/$MANAGER_USER/g" $CATALINA_HOME/conf/tomcat-users.xml; sed -i "s/MANAGER_ADMIN_PASSWORD/$MANAGER_PASSWORD/g" $CATALINA_HOME/conf/tomcat-users.xml;
		#Else echo debug message
		else
			echo "Skipping MANAGER ENV commands";
    		fi
    
    		# IF statement for further case analysis, if different commands are runed into docker exec
    		if [ "$1" = "start" ]; then
    			echo "$(date +%F-%R)" >> ${CATALINA_HOME}/container_first_time_run
    			#ls -lah $CATALINA_HOME/bin/
    
    			sh $CATALINA_HOME/bin/catalina.sh run
    		fi
	fi
fi

exec "$@"
