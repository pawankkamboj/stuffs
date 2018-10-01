FROM confluent/platform
MAINTAINER contact@confluent.io

COPY rest-proxy-docker.sh /usr/local/bin/

RUN chown -R confluent:confluent /etc/kafka-rest /usr/local/bin/rest-proxy-docker.sh && \
    chmod +x /usr/local/bin/rest-proxy-docker.sh

EXPOSE 8082
CMD [ "/usr/local/bin/rest-proxy-docker.sh" ]

