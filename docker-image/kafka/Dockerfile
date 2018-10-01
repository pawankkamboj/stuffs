#- pull base image.
FROM jdk:8u121

USER root 
ADD kafka /data/appuser/kafka
RUN yum -y install which nmap-ncat && \
	chown appuser.appuser /data/appuser/kafka -R

USER appuser
WORKDIR /data/appuser/kafka
ENTRYPOINT ["bin/kafka-server-start.sh"]
CMD ["config/server.properties"]

