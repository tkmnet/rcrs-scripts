#!/bin/sh

KERNEL_LOG=`dirname $0`/kernel.log

if ! [ -e $KERNEL_LOG ]; then
	KERNEL_LOG=`dirname $0`/logs/kernel.log
fi

if [ $# = 1 ]; then
	KERNEL_LOG=$1/kernel.log
fi

grep -a -C 0 'Score:' $KERNEL_LOG | tail -n 1 | grep -o 'Score:.*'
