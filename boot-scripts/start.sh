#! /bin/bash

cd `dirname $0`

. functions.sh

processArgs $*

# Delete old logs
rm -f $LOGDIR/*.log

#startGIS
startKernel --nomenu
startSims

echo "Start your agents"
waitFor $LOGDIR/kernel.log "Kernel is shutting down" 30
timeout 30 waitFor $LOGDIR/kernel.log "Kernel has shut down" 30

kill $PIDS
sh ./kill.sh
sh ./print-lastscore.sh
