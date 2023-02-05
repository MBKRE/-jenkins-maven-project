#!/bin/sh

export public_ip=`terraform output "public_ip"|tr -d '"'`
scp -i ${SSH_KEY_UBUNTU} ./target/hello.war ubuntu@$public_ip:/root/webapps
