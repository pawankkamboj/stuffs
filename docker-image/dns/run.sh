#!/bin/bash
set -m

# common function
setup()
{
        if [ "$NODEIP" ]
        then
		sed -i "s|IPADDR|$NODEIP|g" /opt/namedfile/master.conf
		sed -i "s|IPADDR|$NODEIP|g" /opt/namedfile/slave.conf
		chown named.named /var/named -R
	else
		echo "Specify NODEIP"
		exit 4
	fi
	
	echo $ALLOW_QUERY
	echo $ALLOW_NOTIFY
	echo $TRANSFER
	echo $MASTER
	echo $NODEIP
	echo $ZONENAME
}

master()
{
	cp -rp /opt/namedfile/master.conf /etc/named.conf


        if [ "$ZONENAME" ]
        then
                sed -i "s|ZONENAME|$ZONENAME|g" /etc/named.conf
        else
                echo "Specify ZONENAME"
                exit 1
        fi

	if [ "$ALLOW_QUERY" ]
	then
		sed -i "s|QUERY|$ALLOW_QUERY|g" /etc/named.conf
	else
		echo "Specify ALLOW_QUERY"
		exit 1
	fi

	if [ "$ALLOW_NOTIFY" ]
        then
                sed -i "s|NOTIFY|$ALLOW_NOTIFY|g" /etc/named.conf
        else
                echo "Specify ALLOW_NOTIFY"
                exit 1
	fi

        if [ "$TRANSFER" ]
        then
                sed -i "s|TRANSFER|$TRANSFER|g" /etc/named.conf
        else
                echo "Specify TRANSFER DNS"
                exit 1
	fi

	echo "check named conf -- /etc/named.conf"
	/usr/sbin/named-checkconf 
	if [ $? == "1" ]
	then 
		echo "/etc/named.conf having some issue"
		exit 1
	fi

	echo "Starting named on master....."
        exec /usr/sbin/named -u named -4 -g
}

slave()
{
	cp -rp /opt/namedfile/slave.conf /etc/named.conf

        if [ "$ZONENAME" ]
        then
                sed -i "s|ZONENAME|$ZONENAME|g" /etc/named.conf
        else
                echo "Specify ZONENAME"
                exit 1
        fi

	if [ "$ALLOW_QUERY" ]
        then
                sed -i "s|QUERY|$ALLOW_QUERY|g" /etc/named.conf
        else
                echo "Specify ALLOW_QUERY"
                exit 1
	fi

	if [ "$MASTER" ]
        then
                sed -i "s|MASTER|$MASTER|g" /etc/named.conf
        else
                echo "Specify ALLOW_QUERY"
                exit 1
	fi

	echo "check named conf -- /etc/named.conf"
        /usr/sbin/named-checkconf
        if [ $? == "1" ]
        then
                echo "/etc/named.conf having some issue"
                exit 1
        fi

	echo "Starting named on slave.."
	exec /usr/sbin/named -u named -4 -g
}

# initilize script here
#- setup
setup

case "$1" in
slave)
        slave
        ;;
master)
        master
        ;;
*)
        echo "Invalid Environment, check with Linux Team"
        exec "$@"
        ;;
esac

