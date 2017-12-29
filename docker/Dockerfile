FROM centos
MAINTAINER Pawan Kamboj "pawank.kamboj@gmail.com"

#- update base image and install quagga router
RUN yum -y update && \
	yum install -y quagga && \
	yum clean all

#- env
ENV BGP_Self_ASN="64512"

#- copy config file
COPY bgpd.conf /etc/quagga/bgpd.conf
COPY zebra.conf /etc/quagga/zebra.conf

#- copy run.sh
COPY run.sh /usr/bin/run.sh

#- startup
ENTRYPOINT ["/usr/bin/run.sh"]
CMD  ["bgp"]

