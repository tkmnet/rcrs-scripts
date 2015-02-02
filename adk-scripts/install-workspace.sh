#!/bin/sh

WGET='wget'
if ! [ -x `which wget||echo @` ]; then
	if [ -x `which curl||echo @` ]; then
		WGET='curl -O'
	else
		sudo apt-get install -y wget
		sh -c "sh $0"
		exit
	fi
fi

TMPDIR="adk-workspace.$$.tmp"
mkdir $TMPDIR
cd $TMPDIR

$WGET http://aitech.ac.jp/maslab/labsys/ComlibDL/adk-workspace.zip
unzip ./adk-workspace.zip
ADKDIR=`find -maxdepth 1 -mindepth 1 -type d | sed -E 's%./%%g'`
rm ./adk-workspace.zip
cd $ADKDIR

cd workspace
GITHUB_CONTENTS='https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/adk-scripts/'
$WGET ${GITHUB_CONTENTS}.build.sh
$WGET ${GITHUB_CONTENTS}.start.sh
$WGET ${GITHUB_CONTENTS}.libs-update.sh
cd ..

cd ..
mv $ADKDIR ../
cd ..
rm -rf $TMPDIR

echo "Done."
