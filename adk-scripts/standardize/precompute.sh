#!/bin/sh

cd `dirname $0`

chmod a+x ./gradle/gradle-2.1/bin/gradle
./gradle/gradle-2.1/bin/gradle -Pargs="-h:$7 -fb:$1 -fs:$2 -pf:$3 -po:$4 -at:$5 -ac:$6 -pre:true" start
