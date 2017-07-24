FROM ubuntu:16.04

#Forked from maintainer Carlos Moro
MAINTAINER Nicolae Rosu <nrosu@pentalog.fr>

ENV TOMCAT_VERSION 8.5.16
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

# Set the locale
RUN apt-get clean && apt-get update && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get install locales vim mc -y --force-yes && \
	locale-gen en_US.UTF-8 && \
	rm /bin/sh && ln -s /bin/bash /bin/sh && \
	apt-get update && \
	apt-get install -y --force-yes  git build-essential curl wget software-properties-common && \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	apt-get update -y && \
	apt-get install -y --force-yes oracle-java8-installer wget unzip tar && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer && \
	wget --quiet --no-cookies http://mirrors.m247.ro/apache/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
	tar xzvf /tmp/tomcat.tgz -C /opt && \
	mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
	rm /tmp/tomcat.tgz

# Removing this in 0.1
# Set locales
#RUN locale-gen en_GB.UTF-8
#ENV LANG en_GB.UTF-8
#ENV LC_CTYPE en_GB.UTF-8

# Install JDK 8

# Define commonly used JAVA_HOME variable

# Get Tomcat
	#Leaving Dummy files. This img is for training not for production.	
	#rm -rf /opt/tomcat/webapps/examples && \
	#rm -rf /opt/tomcat/webapps/docs && \
	#rm -rf /opt/tomcat/webapps/ROOT


#Removed in v0.1
#RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
#tar xzvf /tmp/tomcat.tgz -C /opt && \
#mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
#rm /tmp/tomcat.tgz && \
#rm -rf /opt/tomcat/webapps/examples && \
#rm -rf /opt/tomcat/webapps/docs && \
#rm -rf /opt/tomcat/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml /opt/tomcat/conf/
ADD manager /opt/tomcat/webapps/
ADD host-manager /opt/tomcat/webapps/

EXPOSE 8080
EXPOSE 8009
VOLUME "/opt/tomcat/webapps"
WORKDIR /opt/tomcat

# Launch Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

