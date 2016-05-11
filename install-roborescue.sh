#!/bin/sh

WGET='wget --no-check-certificate'
if ! [ -x `which wget||echo /dev/null` ]; then
	if [ -x `which curl||echo /dev/null` ]; then
		WGET='curl -LO'
	fi
fi

if ! [ -x `which javac||echo /dev/null` ]; then
	if [ `javac -version 2>&1 | grep -o 'javac 1.8.*' | wc -l` != 1 ]; then
		echo "[!] This script repuire java8."
		echo "Please install OracleJDK 8."
#		cd /tmp
#		$WGET https://raw.githubusercontent.com/tkmnet/Tools/master/install-oracle-jdk.sh
#		sh install-oracle-jdk.sh
#		sh -c "sh $0"
		exit
	fi
fi

if ! [ -x `which xterm||echo /dev/null` -a -x `which tar||echo /dev/null` -a -x `which gzip||echo /dev/null` ]; then
    echo "[!] This script repuire tar,gzip,xterm."
    exit
fi

$WGET http://downloads.sourceforge.net/project/roborescue/roborescue/v1.2/roborescue-v1.2.tar.gz
tar zxvf ./roborescue-v1.2.tar.gz
rm ./roborescue-v1.2.tar.gz
cd ./roborescue-v1.2

$WGET 'http://ftp.tsukuba.wide.ad.jp/software/apache//ant/binaries/apache-ant-1.9.7-bin.tar.gz'
tar zxvf ./apache-ant-1.9.6-bin.tar.gz
rm ./apache-ant-1.9.6-bin.tar.gz

$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/fix-roborescue.sh
sh ./fix-roborescue.sh -y
rm ./fix-roborescue.sh

./apache-ant-1.9.6/bin/ant complete-build

echo "Done."
echo "RCRS Server is installed to '`pwd -P`'"
