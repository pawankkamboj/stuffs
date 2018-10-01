#!/bin/bash
# common function
setup()
{
        sudo chown appuser.appuser /data/appuser -R
}

startup()
{
        echo "starting logstash"
        exec /data/appuser/logstash/bin/logstash 

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
