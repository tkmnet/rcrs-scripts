# rcrs-scripts
Shell scripts for RoboCupRescueSimulation

## Install RoboCupRescueSimulation server
**REQUIERD:** apt-get, OracleJDK 8

The server will install on [current directory]/roborescue.
```
wget https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/install-roborescue.sh
sh ./install-roborescue.sh
```
if you do not using wget, you can use `curl -O` as alternative `wget`.

## Fix RoboCupRescueSimulation server for Java8
*if you installed server using "install-roborescue.sh", it is already applied this script.*

Runs commands on the server's root.
```
wget https://raw.githubusercontent.com/tkmnet/rcrs-scripts/master/fix-roborescue.sh
sh ./fix-roborescue.sh
```
