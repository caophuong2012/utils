#!/bin/bash
# Description:      Script to restart tomcat for MEM servers
# Maintener  :      Phuong Cao     phuong.cao@opswat.com
#===============================================================================

tomcat_dir="/usr/local/mem/apache-tomcat-8.0.32"

echo "[INFO] Clean shut down Tomcat service"
ps aux | grep tomcat | grep java
ret=$?
while [ $ret -eq 0 ]
do
  echo "[INFO] Tomcat is still up"
  pkill -f tomcat
  ps aux | grep tomcat | grep java
  ret=$?
done
echo "[INFO] Tomcat is shutdown"
echo "[INFO] Starting Tomcat"
sh $tomcat_dir/bin/startup.sh
