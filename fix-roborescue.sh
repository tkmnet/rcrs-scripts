#!/bin/sh

WGET='wget --no-check-certificate'
if ! [ -x `which wget||echo @` ]; then
	if [ -x `which curl||echo @` ]; then
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

if ! [ -d boot -a -d build-tools -a -d modules -a -d supplement -a -e build.xml ]; then
echo "[!] This directory is not roborescue-server root."
exit
fi

pwd

yesflag=0
if [ $# -eq 1 ]; then
	if [ $1 = '-y' ]; then
		yesflag=1
	fi
fi

if [ $yesflag -eq 0 ]; then
    echo -n 'Really run fixing? (in some cases, files is destroyed) [y/N] > '
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
mv start-precompute.sh start-precompute.sh.org
mv start-comprun.sh start-comprun.sh.org
mv functions.sh functions.sh.org
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/functions.sh  >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/start.sh >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/start-precompute.sh >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/start-comprun.sh >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/kill.sh >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/print-lastscore.sh >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/noXterm-functions.sh >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/noGUI-functions.sh >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/noGUI-start-precompute.sh >/dev/null 2>&1
$WGET https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/boot-scripts/noGUI-start-comprun.sh >/dev/null 2>&1
chmod a+x start*.sh
chmod a+x kill.sh
chmod a+x print-lastscore.sh
cd ..

#find ./ -name "build*.xml" | xargs sed -i -e 's/<javac\(.*\)>/<javac\1  encoding="UTF-8">/g'
find ./ -name "build*.xml" | xargs sed -i -e 's/\(.*\)\(importClass(org.apache.tools.ant.types.Path);\)/\1load("nashorn:mozilla_compat.js");\
\1\2/g'


touch .var01.tkmnet.fixed
echo "Done."
