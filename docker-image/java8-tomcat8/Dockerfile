#- pull base image.
FROM centos-base:7.5

#update
RUN yum -y update && yum clean all && rm -rf /var/cache/yum

# add tomcat and java
ADD java/jdk-8u171-linux-x64.tar.gz /data/appuser/java/
ADD tomcat/apache-tomcat-8.5.31.tar.gz /tmp/
RUN ln -s `ls -d /data/appuser/java/*` /data/appuser/java/latest && \
        mv /tmp/apache-tomcat-8.5.31 /data/appuser/run/tomcat && \
        cd /data/appuser/run/tomcat && \
        rm -rf bin/*.bat webapps/* && \
	sed -i 's|JPDA_ADDRESS="localhost:8000"|JPDA_ADDRESS="8000"|g' /data/appuser/run/tomcat/bin/catalina.sh && \ 
	rm -rf /etc/security/limits.d/* && \
	find ./bin/ -name '*.sh' -exec sed -ri 's|^#!/bin/sh$|#!/usr/bin/env bash|' '{}' +

ADD tomcat/org /data/appuser/run/tomcat/lib/org
COPY server.xml /data/appuser/run/tomcat/conf/server.xml
ADD hostfile /data/appuser/hostfile

#- add startup file
COPY run.sh /usr/bin/run.sh

#- edit /etc/profile - set JAVA_HOME
RUN echo 'export JAVA_HOME=/data/appuser/java/latest' >> /etc/profile.d/appuser.sh && \
	echo 'export CATALINA_HOME="/data/appuser/run/tomcat"' >> /etc/profile.d/appuser.sh && \
	echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/appuser.sh

#- switch to appuser
USER appuser

#- work dir
WORKDIR /data/appuser

#- setup tomcat and java and other env variable
ENV JAVA_HOME="/data/appuser/java/latest" JRE_HOME="/data/appuser/java/latest/jre" CATALINA_HOME="/data/appuser/run/tomcat" \
        PATH="$JAVA_HOME/bin:$HOME/bin:/usr/bin:$PATH" \
        TOMCAT_VERSION="8.5.31" \
        JAVA_VERSION="8u171"

#- expose port 
EXPOSE 8080

#- entrypoint script
ENTRYPOINT ["/usr/bin/run.sh"]

#- command to run for container
#- Use QA to run on QA - default will run on QA
#- Use PROD to run on PROD
CMD  ["PROD"]
