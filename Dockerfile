FROM ubuntu:16.04

#Forked from maintainer Carlos Moro
MAINTAINER Nicolae Rosu <nrosu@pentalog.fr>

ENV TOMCAT_VERSION=8.5.16 \
	CATALINA_HOME="/opt/tomcat" \
	TOMCAT_LOG="/var/log/catalina" \
	TOMCAT_WEBAPPS="${CATALINA_HOME}/webapps" \
	JAVA_HOME="/usr/lib/jvm/java-8-oracle" \
	MANAGER_ALLOW_REMOTE=${MANAGER_ALLOW_REMOTE:-true} \
	MANAGER_USER=${MANAGER_USERNAME:-admin} \
	MANAGER_PASSWORD=${MANAGER_PASSWORD:-admin} \
	PATH=${PATH}:${CATALINA_HOME}/bin 

# Set the locale install PPA, install Tomcat.
RUN apt-get clean && apt-get update && \
	apt-get install locales vim mc -y --force-yes && \
	locale-gen en_US.UTF-8 && \
	rm /bin/sh && ln -s /bin/bash /bin/sh && \
	apt-get update && \
	apt-get install -y --force-yes  git build-essential curl wget software-properties-common && \
        add-apt-repository -y ppa:webupd8team/java && \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	apt-get update -y && \
	apt-get install -y --force-yes oracle-java8-installer wget unzip tar && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer && \
	wget --quiet --no-cookies http://mirrors.m247.ro/apache/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
	tar xzvf /tmp/tomcat.tgz -C /opt && \
	mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
	rm /tmp/tomcat.tgz

# Add admin/admin user
ADD tomcat-users.xml ${CATALINA_HOME}/conf/
ADD manager ${TOMCAT_WEBAPPS}
ADD host-manager ${TOMCAT_WEBAPPS}

EXPOSE 8080 8009
VOLUME ["${TOMCAT_WEBAPPS}", "${TOMCAT_LOG}"]
WORKDIR ${CATALINA_HOME}

# Launch Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]


