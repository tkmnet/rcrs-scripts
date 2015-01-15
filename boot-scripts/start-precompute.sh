#! /bin/bash

cd `dirname $0`

rm -f ./server.pids.tmp

. functions.sh

processArgs $*

# Delete old logs
rm -f $LOGDIR/*.log

#startGIS
startKernel --nomenu

$PIDS > ./server.pids.tmp

echo "Start your agents"
waitFor $LOGDIR/kernel.log "Kernel has shut down" 30

rm -f ./server.pids.tmp
kill $PIDS
