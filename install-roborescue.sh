#!/bin/sh

if [ ! -x `which apt-get` ]; then
	echo "[!] This script repuire apt-get."
	exit
fi

if [ -x `which javac` ]; then; else
	if [ `javac -version 2>&1 | grep -o 'javac 1.8.*' | wc -l` != 1 ]; then
		echo "[!] This script repuire java8."
		echo "Please install OracleJDK 8."
		exit
	fi
fi

WGET='wget'
if [ -x `which wget` ]; then; else
	if [ -x `which curl` ]; then
		WGET='curl -O'
	else
		sudo apt-get install -y wget
		sh -c ./install-roborescue.sh
		exit
	fi
fi

if [ -x `which ant`  -a -x `which xterm` -a -x `which tar` -a -x `which gzip` ]; then; else
	sudo apt-get install -y ant xterm tar gzip
	sh -c ./install-roborescue.sh
	exit
fi

$WGET http://downloads.sourceforge.net/project/roborescue/2014/server/roborescue.tar.gz
tar zxvf ./roborescue.tar.gz
rm ./roborescue.tar.gz
cd ./roborescue

$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/fix-roborescue.sh
sh ./fix-roborescue.sh -y
rm ./fix-roborescue.sh

ant complete-build

echo "Done."
echo "RCRS Server is installed to '`pwd -P`'"
