#!/bin/sh

WGET='wget --no-check-certificate'
if ! [ -x `which wget||echo @` ]; then
	if [ -x `which curl||echo @` ]; then
		WGET='curl -O'
	else
		if ! [ -x `which apt-get||echo @` ]; then
			echo "[!] This script repuire apt-get."
			exit
		fi
		sudo apt-get install -y wget
		sh -c "sh $0"
		exit
	fi
fi

if ! [ -x `which javac||echo @` ]; then
	if [ `javac -version 2>&1 | grep -o 'javac 1.8.*' | wc -l` != 1 ]; then
		echo "[!] This script repuire java8."
		echo "Please install OracleJDK 8."
		cd /tmp
		$WGET https://raw.githubusercontent.com/tkmnet/Tools/master/install-oracle-jdk.sh
		sh install-oracle-jdk.sh
		sh -c "sh $0"
		exit
	fi
fi

if ! [ -x `which ant||echo @`  -a -x `which xterm||echo @` -a -x `which tar||echo @` -a -x `which gzip||echo @` ]; then
	if ! [ -x `which apt-get||echo @` ]; then
		echo "[!] This script repuire apt-get."
		exit
	fi
	sudo apt-get install -y ant xterm tar gzip
	sh -c "sh $0"
	exit
fi

$WGET http://downloads.sourceforge.net/project/roborescue/2014/server/roborescue.tar.gz
tar zxvf ./roborescue.tar.gz
rm ./roborescue.tar.gz
cd ./roborescue

#$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/fix-roborescue.sh
#sh ./fix-roborescue.sh -y
#rm ./fix-roborescue.sh

ant complete-build

echo "Done."
echo "RCRS Server is installed to '`pwd -P`'"
