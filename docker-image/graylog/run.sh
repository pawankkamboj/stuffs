#!/bin/bash
set -m
set -e 
# common function
setup()
{
        chown appuser.appuser /data/appuser -R
	# allow for memlock
	#ulimit -l unlimited
	sysctl -w vm.max_map_count=262144
}

startup()
{
        echo "starting graylog"
        /usr/local/bin/su-exec appuser /data/appuser/java/latest/bin/java ${JAVA_OPTS} ${GRAYLOG_SERVER_JAVA_OPTS} -Dlog4j.configurationFile=${LOG4J} -Djava.library.path=${LD_PATH} -jar ${GRAYLOG_JAR} server -f ${CONFIG_FILE} -p /tmp/graylog.pid

}

#- run script
case "$1" in
startup)
	setup
        startup
        ;;
*)
	setup
        exec "$@"
        ;;
esac
