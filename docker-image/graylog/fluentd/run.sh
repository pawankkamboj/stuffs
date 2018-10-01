#!/bin/bash
startup()
{
        cd /etc/init.d/ && ./td-agent start
	if [ $? -eq 0 ]
	then
		tail -f /var/log/td-agent/td-agent.log
	else
		echo "fail to start td-agent"
		exit 1
	fi
}

#- run script
case "$1" in
startup)
        startup
        ;;
*)
        exec "$@"
        ;;
esac
