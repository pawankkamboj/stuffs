#!/bin/bash

sudo chown appuser:appuser /data/appuser/zookeeper -R
sh -c  /data/appuser/zookeeper/bin/zkGenConfig.sh 
exec "$@"
