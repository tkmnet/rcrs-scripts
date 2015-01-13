#!/bin/sh

if [ -e .var01.tkmnet.fixed ]; then
echo "This directory is already fixed."
exit
fi

if [ ! -d boot -o ! -d build-tools -o ! -d modules -o ! -d supplement -o ! -e build.xml ]; then
echo "This directory is not roborescue-server root."
exit
fi

pwd
echo -n 'Really want to fix? [y/N] > '
read answer
 
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
wget https://gist.githubusercontent.com/tkmnet/d9dba3746d46786508d4/raw/0f509cd9799cc668d8f3609d13e152ebe261c9da/functions.sh 2> /dev/null > /dev/null
wget https://gist.githubusercontent.com/tkmnet/d9dba3746d46786508d4/raw/004d0c861ab7f212a9f1d281a339034892b03d06/start.sh 2> /dev/null > /dev/null
chmod a+x start.sh
cd ..

find ./ -name "build*.xml" | xargs sed -i -e 's/<javac\(.*\)>/<javac\1  encoding="UTF-8">/g'
find ./ -name "build*.xml" | xargs sed -i -e 's/\(.*\)\(importClass(org.apache.tools.ant.types.Path);\)/\1load("nashorn:mozilla_compat.js");\n\1\2/g'


touch .var01.tkmnet.fixed
echo "Done."