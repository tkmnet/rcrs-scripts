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

if ! [ -x `which tar||echo /dev/null` -a -x `which gzip||echo /dev/null` ]; then
    echo "[!] This script repuire tar,gzip."
    exit
fi

#ANTVER=`wget -O - "http://ftp.riken.jp/net/apache//ant/binaries/" | grep -s 'a.* href=".*-bin\.tar\.gz"' | sed -e 's/^.* href="\(apache-ant-.*\)".*$/\1/' | head -1 | sed -e 's/-bin\.tar\.gz$//'`
ANTVER='apache-ant-1.10.0'

$WGET http://downloads.sourceforge.net/project/roborescue/roborescue/v1.2/roborescue-v1.2.tar.gz
tar zxvf ./roborescue-v1.2.tar.gz
rm ./roborescue-v1.2.tar.gz
cd ./roborescue-v1.2

$WGET "http://ftp.riken.jp/net/apache//ant/binaries/${ANTVER}-bin.tar.gz"
tar zxvf ./${ANTVER}bin.tar.gz
rm ./${ANTVER}-bin.tar.gz

$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/fix-roborescue.sh
sh ./fix-roborescue.sh -y
rm ./fix-roborescue.sh

./${ANTVER}/bin/ant complete-build

echo "Done."
echo "RCRS Server is installed to '`pwd -P`'"
