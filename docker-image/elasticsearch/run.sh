#!/bin/bash
set -m
set -e 
# common function
setup()
{
        mkdir /data/appuser/elasticsearch/backup
        chown appuser.appuser /data/appuser -R
	# allow for memlock
	ulimit -l unlimited
	sysctl -w vm.max_map_count=262144
}

startup()
{
        echo "starting elasticsearch"
        /usr/local/bin/su-exec appuser /data/appuser/elasticsearch/bin/elasticsearch
}

#- run script
case "$1" in
startup)
	setup
        startup
        ;;
*)
	setup
        echo "Please provide Environment - QA/RFS/PROD, check with Linux Team for more info"
        exec "$@"
        ;;
esac
