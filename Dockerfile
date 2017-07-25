FROM ubuntu:16.04

#Forked from maintainer Carlos Moro

MAINTAINER Nicolae Rosu <rnicolae90@gmail.com>

ENV TOMCAT_VERSION=8.5.16 \
	CATALINA_HOME="/opt/tomcat" \
	TOMCAT_LOG="/var/log/catalina" \
	TOMCAT_WEBAPPS="${CATALINA_HOME}/webapps" \
        TOMCAT_MANAGER=${TOMCAT_MANAGER:-/opt/tomcat/webapps} \
	JAVA_HOME="/usr/lib/jvm/java-8-oracle" \
	MANAGER_ALLOW_REMOTE=${MANAGER_ALLOW_REMOTE:-false} \
	MANAGER_USER=${MANAGER_USER:-admin} \
	MANAGER_PASSWORD=${MANAGER_PASSWORD:-admin} \
	PATH=${PATH}:${CATALINA_HOME}/bin 

# Set the locale install PPA, install Tomcat.
RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main' > /etc/apt/sources.list.d/webupd8team-ubuntu-java-xenial.list && \
	apt-get clean && apt-get update && \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	apt-get install -y --force-yes --no-install-recommends oracle-java8-installer  && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer && \
	wget --quiet --no-cookies http://mirrors.m247.ro/apache/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
        tar xzvf /tmp/tomcat.tgz -C /opt && \
        mv /opt/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} && \
	rm /tmp/tomcat.tgz

# Add admin/admin user
# ADD tomcat-users.xml ${CATALINA_HOME}/conf/
ADD entrypoint.sh /

EXPOSE 8080 8009
VOLUME ["${TOMCAT_WEBAPPS}", "${TOMCAT_LOG}"]
#WORKDIR ${CATALINA_HOME}

# Launch Tomcat
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]


