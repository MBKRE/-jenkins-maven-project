#!/bin/sh

export public_ip=`terraform output "public_ip"|tr -d '"'`

