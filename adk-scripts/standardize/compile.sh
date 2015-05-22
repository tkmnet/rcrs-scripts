#!/bin/sh

cd `dirname $0`


chmod a+x ./gradle/gradle-2.1/bin/gradle
./gradle/gradle-2.1/bin/gradle build
