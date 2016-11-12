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

if ! [ -x `which git||echo @` -a -x `which tar||echo @` -a -x `which gzip||echo @` ]; then
	if ! [ -x `which apt-get||echo @` ]; then
		echo "[!] This script repuire apt-get."
		exit
	fi
	sudo apt-get install -y tar gzip git
	sh -c "sh $0"
	exit
fi

mkdir rmasbench
cd rmasbench
mkdir .builder
cd .builder

$WGET 'http://ftp.jaist.ac.jp/pub/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz'
tar xvf apache-maven-3.3.3-bin.tar.gz
mv apache-maven-3.3.3 maven

$WGET 'http://ftp.yz.yamagata-u.ac.jp/pub/network/apache//ant/binaries/apache-ant-1.9.6-bin.tar.gz'
tar xvf apache-ant-1.9.6-bin.tar.gz
mv apache-ant-1.9.6 ant


cd ..

git clone --recursive https://github.com/RMASBench/RMASBench.git

cd RMASBench
cd BinaryMaxSum; ../../.builder/maven/bin/mvn -DskipTests package; cd ..
cd MaxSum; ../../.builder/ant/bin/ant jar; cd ..
cd roborescue; ../../.builder/ant/bin/ant oldsims jars; cd ..
cd BlockadeLoader; ../../.builder/ant/bin/ant jar; cd ..
cd RSLB2; ../../.builder/ant/bin/ant jar

cd ..
cd ..

mkdir map
mkdir scenario
mkdir team

cp -r RMASBench/RSLB2 team/sampleBMS
cd team/sampleBMS
cp dist/lib/bms-1.0.1-SNAPSHOT-all.jar lib/
cp dist/lib/kernel.jar lib/
cp dist/lib/standard.jar lib/
cp dist/lib/rescuecore2.jar lib/
cd src/main/java/RSLBench/
cp -r Algorithms/BMS ./
rm -rf Algorithms
mkdir Algorithms
mv BMS Algorithms/
cd ../../../../
ant clean






echo
echo "Done."
echo "RMAS Bench is installed to '`pwd -P`'"
