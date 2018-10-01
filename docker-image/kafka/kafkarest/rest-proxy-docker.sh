#!/bin/bash

RP_CFG_FILE="/etc/kafka-rest/kafka-rest.properties"

HOST=`hostname`
ID="${HOST: -1}"

#/usr/bin/docker-edit-properties --file ${RP_CFG_FILE} --include 'KAFKA_REST_(.*)' --include 'RP_(.*)' --exclude '^RP_CFG_'
echo "id=$ID" > /etc/kafka-rest/kafka-rest.properties
echo "port=8082" >> /etc/kafka-rest/kafka-rest.properties
echo "schema.registry.url=$KAFKA_REST_SCHEMA_REGISTRY_URL" >> /etc/kafka-rest/kafka-rest.properties
echo "zookeeper.connect=$KAFKA_REST_ZOOKEEPER_CONNECT" >> /etc/kafka-rest/kafka-rest.properties
echo "consumer.request.max.bytes=204800" >> /etc/kafka-rest/kafka-rest.properties
echo "host.name=$HOST" >> /etc/kafka-rest/kafka-rest.properties
echo "listeners=http://0.0.0.0:8082" >> /etc/kafka-rest/kafka-rest.properties

# Fix for issue #77, PR #78: https://github.com/confluentinc/kafka-rest/pull/78/files
sed -i 's/\"kafka\"//' /usr/bin/kafka-rest-run-class

# HACK This is a total hack to get around launching several containers at once. This give zookeeper and kafka time to start.
sleep 10

exec /usr/bin/kafka-rest-start ${RP_CFG_FILE}
