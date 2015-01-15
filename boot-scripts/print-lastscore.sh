#!/bin/sh

KERNEL_LOG=`dirname $0`/kernel.log

if [ $# = 1 ]; then
	KERNEL_LOG=$1/kernel.log
fi

grep -a -C 0 'Score:' $KERNEL_LOG | tail -n 1 | grep -o 'Score:.*'
