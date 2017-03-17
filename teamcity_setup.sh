#!/bin/bash

echo "INSTALL TEAMCITY ON CENTOS"

echo "[INFO] Cleaning up Teamcity root directory"
rm -rf /$(whoami)/.BuildServer
mkdir /$(whoami)/.BuildServer

echo "[INFO] Setting up require sites"
yum install java-openjdk -y
yum install mysql-connector-java -y
cd /var/www/temp
tar -xvf mysql-connector-java-5.1.41.tar.gz
cp mysql-connector-java-5.1.41/mysql-connector-java-5.1.41-bin.jar /$(whoami)/.BuildServer/lib/jdbc

echo "[INFO] Setting up teamcity"
cd /var/www/html
rm -rf teamcity
mkdir teamcity
cd teamcity
wget https://download.jetbrains.com/teamcity/TeamCity-10.0.5.tar.gz
tar xpf TeamCity-10.0.5.tar.gz

echo "[INFO] Starting teamcity service"
/var/www/html/teamcity/TeamCity/bin/runAll.sh start

echo "[INFO] Creating teamcity table"
if [ ! -d /var/lib/mysql/teamcity ]; then
  mysql -uroot -p'P@ssword' -e "CREATE DATABASE teamcity DEFAULT CHARACTER SET utf8"
  mysql -uroot -p'P@ssword' -e "GRANT USAGE ON *.* TO 'teamcity'@'localhost' IDENTIFIED BY 'P@ssword'"
  mysql -uroot -p'P@ssword' -e "GRANT ALL ON teamcity.* TO 'teamcity'@'localhost'"
  mysql -uroot -p'P@ssword' -e "flush privileges"
fi
