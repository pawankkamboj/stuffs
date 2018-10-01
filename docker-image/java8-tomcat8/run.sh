#!/bin/bash
set -m

# common function
setup()
{
        NODEIP=`ip -4 -f inet addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1`
        NAME1=`echo $NODEIP | awk -F"." '{print$3"-"$4}'`
        NAME="appuser-${NAME1}"
	sudo setfacl -m u:appuser:rwx /etc/hosts
        sudo chown appuser.appuser /data/appuser -R

        sed -i "s/SERVERNAME/$NAME/g" /data/appuser/run/tomcat/conf/server.xml

        rm -rf /data/appuser/run/tomcat/logs
        mkdir /data/appuser/logs/${NODEIP}/logs -p
        ln -s /data/appuser/logs/${NODEIP}/logs /data/appuser/run/tomcat/logs
}

# qa run function
setupqa()
{
	echo "starting $1 environment"
	echo "setting jvm options"
        if [ "$JVM_OPTS" ]
        then
        	export JAVA_OPTS="$JVM_OPTS"
        else
                export JAVA_OPTS="-Xms1024M -Xmx1024M"
        fi

	#P1=`tr -cd '[:alnum:]' < /dev/urandom | fold -w4 | head -n1`
	echo "appuser:appuser#007" | sudo chpasswd

        echo "starting tomcat"
        rm -rf /data/appuser/run/tomcat/work/* /data/appuser/run/tomcat/temp/* /data/appuser/run/tomcat/logs/*
        /bin/sh /data/appuser/run/tomcat/bin/catalina.sh jpda start

	echo "starting sshd for $1 server"
	echo "login password is == appuser#007"
	sudo /usr/sbin/sshd -D
}


setupprod()
{
	echo "starting PROD environment"

	echo "setting jvm option"
	if [ "$JVM_OPTS" ]
	then
		export JAVA_OPTS="$JVM_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/appuser/run/tomcat/logs/ -XX:OnOutOfMemoryError="/data/appuser/hostfile/OutOfMemory.sh""
	else
	        export JAVA_OPTS="-Xms1024M -Xmx1024M"
	fi

	echo "starting tomcat..."
	rm -rf /data/appuser/run/tomcat/work/* /data/appuser/run/tomcat/temp/*
	exec /bin/sh /data/appuser/run/tomcat/bin/catalina.sh run
}

# initilize script here
#- setup
setup

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
