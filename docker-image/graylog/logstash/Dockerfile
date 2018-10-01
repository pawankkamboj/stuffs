FROM jdk:8u121 

#- Install Elasticsearch.
USER root
ENV VERSION 6.2.3
RUN wget -q https://artifacts.elastic.co/downloads/logstash/logstash-$VERSION.tar.gz && \
  tar zxf logstash-$VERSION.tar.gz && \
  mv logstash-$VERSION logstash && \
  rm -rf logstash-$VERSION.tar.gz logs run YT && \
  /data/appuser/logstash/bin/logstash-plugin install logstash-output-gelf && \
  /data/appuser/logstash/bin/logstash-plugin install logstash-filter-prune

#- Set environment
COPY config /data/appuser/logstash/config
COPY run.sh /data/appuser/logstash/bin/run.sh

#- user
USER appuser

#- entry point
ENTRYPOINT ["/data/appuser/logstash/bin/run.sh"]

#- command
CMD ["startup"]
