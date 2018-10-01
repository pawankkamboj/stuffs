#!/bin/bash
set -m

# qa run function
setupqa()
{

        P1=`tr -cd '[:alnum:]' < /dev/urandom | fold -w4 | head -n1`
        echo "appuser:appuser#${P1}" | sudo chpasswd

        echo "Starting kafka server..."
	sudo chown appuser.appuser /data/appuser/kafka -R
	rm -f /data/appuser/kafka/kafka-logs/meta.properties

	cd /data/appuser/kafka
	nohup ./bin/kafka-server-start.sh config/server.properties --override broker.id=$(hostname | awk -F'-' '{print $NF}') --override zookeeper.connect=$ZOOKEEPER_CONNECT &

        echo "Starting sshd for QA server...."
        echo "Login password is ==  appuser#${P1}"
        sudo /usr/sbin/sshd -D
}

setupprod()
{
        echo "Starting kafka server..."
	sudo chown appuser.appuser /data/appuser/kafka /data/appuser/jmx_prometheus -R
	rm -f /data/appuser/kafka/kafka-logs/meta.properties
	nohup /data/appuser/java/latest/bin/java -jar /data/appuser/jmx_prometheus/jmx_prometheus_httpserver.jar 5556 /data/appuser/jmx_prometheus/kafka.yml &
	cd /data/appuser/kafka
	exec ./bin/kafka-server-start.sh config/server.properties --override broker.id=$(hostname | awk -F'-' '{print $NF}') --override zookeeper.connect=$ZOOKEEPER_CONNECT
}

# initilize script here
case "$1" in
QA|RFS)
        setupqa
        ;;
PROD)
        setupprod
        ;;
*)
        echo "Invalid Environment, check with Linux Team"
        exec "$@"
        ;;
esac

