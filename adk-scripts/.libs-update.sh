WGET='wget --no-cache'
if ! [ -x `which wget||echo @` ]; then
	if [ -x `which curl||echo @` ]; then
		WGET='curl -O'
	else
		sudo apt-get install -y wget
		sh -c "sh $0"
		exit
	fi
fi

MYDIR=`pwd`
rm -rf library

TMPDIR="adk-workspace.$$.tmp"
mkdir $TMPDIR
cd $TMPDIR

$WGET http://aitech.ac.jp/maslab/labsys/ComlibDL/adk-workspace.zip
unzip ./adk-workspace.zip
ADKDIR=`find -maxdepth 1 -mindepth 1 -type d | sed -E 's%./%%g'`
rm ./adk-workspace.zip
cd $ADKDIR
cd workspace
cp -r ./library ${MYDIR}/
cp ./build.gradle ${MYDIR}/
cd $MYDIR
rm -rf $TMPDIR

echo "Done."
