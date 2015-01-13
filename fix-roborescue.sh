#!/bin/sh

WGET='wget'
if [ ! -x `which wget` ]; then
	if [ -x `which curl` ]; then
		WGET='curl -O'
	else
		echo "[!] This script require wget or curl."
		exit
	fi
fi

if [ -e .var01.tkmnet.fixed ]; then
echo "[!] This directory is already fixed."
exit
fi

if [ ! -d boot -o ! -d build-tools -o ! -d modules -o ! -d supplement -o ! -e build.xml ]; then
echo "[!] This directory is not roborescue-server root."
exit
fi

pwd

yesflag=0
if [ $# -eq 1 ]; then
	if [ $1 == '-y' ]; then
		yesflag=1
	fi
fi

if [ $yesflag -eq 0 ]; then
	echo -n 'Really want to fix? [y/N] > '
	read answer
else
	answer='y'
fi
 
case $answer in
y)
echo "Wait a second..."
;;
*)
echo "Cancelled."
exit
;;
esac


find ./ -name "gis.cfg" | xargs sed -i -e 's/=/ : /g'
find ./maps -type d -name "config" | xargs cp ./boot/config/gis.cfg

cd boot
mv start.sh start.sh.org
mv functions.sh functions.sh.org
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/functions.sh  >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/start.sh >/dev/null 2>&1
chmod a+x start.sh
cd ..

find ./ -name "build*.xml" | xargs sed -i -e 's/<javac\(.*\)>/<javac\1  encoding="UTF-8">/g'
find ./ -name "build*.xml" | xargs sed -i -e 's/\(.*\)\(importClass(org.apache.tools.ant.types.Path);\)/\1load("nashorn:mozilla_compat.js");\n\1\2/g'


touch .var01.tkmnet.fixed
echo "Done."
