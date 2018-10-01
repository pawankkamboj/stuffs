#- pull base image.
FROM centos-7:v0

# yum update and install bind
RUN yum -y update && \
	yum -y install bind-* && \
	yum clean all && \
	mkdir /opt/namedfile /var/named/master

#- bind files
COPY master.conf /opt/namedfile/master.conf
COPY slave.conf /opt/namedfile/slave.conf

#- add startup file
COPY run.sh /usr/bin/run.sh

#- default zone name
ENV ZONENAME=appuser

#- expose port
EXPOSE 53 953 8053

#- entrypoint script
ENTRYPOINT ["/usr/bin/run.sh"]

#- command to run for container
#- Use slave to run Slave DNS - default will run on slave
#- Use master to run master DNS
CMD  ["slave"]
