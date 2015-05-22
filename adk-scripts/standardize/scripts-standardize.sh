#!/bin/sh

WGET='wget'
if ! [ -x `which wget||echo /dev/null` ]; then
	if [ -x `which curl||echo /dev/null` ]; then
		WGET='curl -O'
	else
		echo '[!] This script require wget or curl.'
		exit
	fi
fi


mkdir -p gradle
cd gradle
$WGET https://services.gradle.org/distributions/gradle-2.1-all.zip
jar xvf gradle-2.1-all.zip
rm gradle-2.1-all.zip

cd ..

$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/adk-scripts/standardize/start.sh
chmod a+x start.sh
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/adk-scripts/standardize/precompute.sh
chmod a+x precompute.sh
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/adk-scripts/standardize/compile.sh
chmod a+x compile.sh

echo Done
