#! /bin/bash

cd `dirname $0`

sh ./kill.sh

. functions.sh

processArgs $*

# Delete old logs
rm -f $LOGDIR/*.log

#startGIS
startKernel --nomenu --autorun
startSims

$PIDS > ./.server.pids.tmp

echo "Start your agents"
waitFor $LOGDIR/kernel.log "Kernel has shut down" 30

rm -f ./.server.pids.tmp
kill $PIDS
