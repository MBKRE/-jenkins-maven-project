#!/bin/bash
sudo yum update -y
sudo yum install wget
sudo yum install openjdk-8-jdk

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

cd /root
sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz
tar -vxzf apache-maven-3.8.7-bin.tar.gz
export PATH=$PATH:/root/apache-maven-3.8.7-bin/bin
