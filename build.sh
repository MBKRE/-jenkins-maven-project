#!/bin/sh

export public_ip=`terraform output "public_ip"|tr -d '"'`
scp ./target/hello.war ec2-user@$public_ip:$TOMCAT_HOME/webapps
