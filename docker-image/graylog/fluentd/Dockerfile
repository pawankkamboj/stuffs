FROM centos-7:v0

# Install fluentd
USER root
RUN curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent3.sh | sh 
RUN yum -y install libcurl-devel gcc-c++ ruby-devel && \
     /usr/sbin/td-agent-gem install fluent-plugin-kubernetes_metadata_filter && \
     /usr/sbin/td-agent-gem install fluent-plugin-prometheus && \
     /usr/sbin/td-agent-gem install fluent-plugin-gelf-hs

#- copy config files and other
COPY run.sh /usr/bin/run.sh
COPY td-agent /etc/init.d/td-agent

#- entry point
ENTRYPOINT ["/usr/bin/run.sh"]

#- command
CMD ["startup"]
