#!/bin/sh

cd `dirname $0`

kill `cat ./.server.pids.tmp 2>/dev/null` >/dev/null 2>&1
rm -f ./.server.pids.tmp
