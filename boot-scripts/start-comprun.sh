#! /bin/bash

cd `dirname $0`

. noXterm-functions.sh

processArgs $*

if ! [ -x `which timeout||echo /dev/null` ]; then
  function timeout() { perl -e 'alarm shift; exec @ARGV' "$@"; }
fi

# Delete old logs
rm -f $LOGDIR/*.log

#startGIS
startKernel --nomenu --autorun
startSims

echo "Start your agents"
waitFor $LOGDIR/kernel.log "Kernel is shutting down" 30
timeout 30 waitFor $LOGDIR/kernel.log "Kernel has shut down" 30

kill $PIDS
sh ./kill.sh
sh ./print-lastscore.sh
