#!/bin/bash
#exec java -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.port=5555 -jar /data/appuser/jmx_prometheus/jmx_prometheus_httpserver.jar 5556 /data/appuser/jmx_prometheus/kafka.yml
java -jar /data/appuser/jmx_prometheus/jmx_prometheus_httpserver.jar 5556 /data/appuser/jmx_prometheus/kafka.yml


