#!/bin/sh

if [ ! -x `which apt-get` ]; then
	echo "[!] This script repuire apt-get."
	exit
fi

if [ ! -x `which javac` ]; then
	if [ `javac -version 2>&1 | grep -o 'javac 1.8.*' | wc -l` != 1 ]; then
		echo "[!] This script repuire java8."
		echo "Please install OracleJDK 8."
		exit
	fi
fi

WGET='wget'
if [ ! -x `which wget` ]; then
	if [ -x `which curl` ]; then
		WGET='curl -O'
	else
		sudo apt-get install wget
		sh -c ./install-roborescue.sh
		exit
	fi
fi

if [ ! -x `which ant`  -o ! -x `which xterm` -o ! -x `which tar` -o ! -x `which gzip` ]; then
		sudo apt-get install ant xterm tar gzip
		sh -c ./install-roborescue.sh
		exit
fi

$WGET http://downloads.sourceforge.net/project/roborescue/2014/server/roborescue.tar.gz
tar zxvf ./roborescue.tar.gz
cd ./roborescue

$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/fix-roborescue.sh¬
sh ./fix-roborescue.sh
rm ./fix-roborescue.sh


echo "Done."
