#!/bin/sh

cd `dirname $0`

if [ $# != 10 ]; then
	echo Usage: $0 MAP CONFIG TEAMDIR MY_IP FIRE_IP FIRE_USER POLICE_IP POLICE_USER AMBULANCE_IP AMBULANCE_USER
	exit
fi


MAP=$1
CONFIG=$2
TEAM=$3
MY_IP=$4
F_IP=$5
F_USER=$6
P_IP=$7
P_USER=$8
A_IP=$9
A_USER=$10


F_SSH="$F_USER@$F_IP"
P_SSH="$P_USER@$P_IP"
A_SSH="$A_USER@$A_IP"


TMP_DIR="/tmp/rcrs.$$"

ssh $F_SSH mkdir $TMP_DIR
scp -r $TEAM $F_SSH:${TMP_DIR}/
ssh $P_SSH mkdir $TMP_DIR
scp -r $TEAM $P_SSH:${TMP_DIR}/
ssh $A_SSH mkdir $TMP_DIR
scp -r $TEAM $A_SSH:${TMP_DIR}/


###############

./start-precompute.sh -m $MAP -c $CONFIG &

sleep 5

ssh $F_SSH "cd $TMP_DIR ; ./precompute.sh 1 0 0 0 0 0 $MY_IP" &
ssh $P_SSH "cd $TMP_DIR ; ./precompute.sh 0 0 1 0 0 0 $MY_IP" &
ssh $A_SSH "cd $TMP_DIR ; ./precompute.sh 0 0 0 0 1 0 $MY_IP" &

sleep 120

kill $PIDS
sh ./kill.sh
ssh $F_SSH killall java
ssh $P_SSH killall java
ssh $A_SSH killall java

###################
sleep 10



ssh $F_SSH "sleep 10 ; cd $TMP_DIR;cd * ; ./start.sh -1 -1 0 0 0 0 $MY_IP" &
ssh $P_SSH "sleep 10 ; cd $TMP_DIR;cd * ; ./start.sh 0 0 -1 -1 0 0 $MY_IP" &
ssh $A_SSH "sleep 10 ; cd $TMP_DIR;cd * ; ./start.sh 0 0 0 0 -1 -1 $MY_IP" &


./start-comprun.sh -m $MAP -c $CONFIG 


sh ./kill.sh
ssh $F_SSH killall java
ssh $P_SSH killall java
ssh $A_SSH killall java




###################


ssh $F_SSH rm -rf $TMP_DIR
ssh $P_SSH rm -rf $TMP_DIR
ssh $A_SSH rm -rf $TMP_DIR



###################

TIMESTAMP=`date +%y%m%d_%H%M%S`
tar zcf "./${TIMESTAMP}-logs.tar.gz" ./logs
sh ./print-lastscore.sh > "./${TIMESTAMP}-score.txt"


sh ./print-lastscore.sh
