#!/bin/bash
sudo su -
sudo apt update -y
sudo apt install wget -y
sudo apt install openjdk-11-jdk -y

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
#echo "export JAVA_HOME=/usr/lib/jvm/java-7-oracle" >>~/.bashrc
#echo "export PATH=$JAVA_HOME/bin:$PATH" >>~/.bashrc
cd /root
sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz
tar -vxzf apache-maven-3.8.7-bin.tar.gz
export PATH=$PATH:/root/apache-maven-3.8.7-bin/bin
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz
tar -vxzf apache-tomcat-9.0.71.tar.gz
sudo cp ./server.xml /root/apache-tomcat-9.0.71/conf
sudo /root/apache-tomcat-9.0.71/bin/startup.sh

