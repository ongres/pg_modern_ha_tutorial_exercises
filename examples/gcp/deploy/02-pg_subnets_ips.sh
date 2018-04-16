#!/bin/bash


basepath=`dirname $0`
source $basepath/functions/deployment-manager.sh


[ $# -eq 1 ] || error "Missing parameter: project name" $0

create_deployment $1 dm-02-pg-subnets-ips $basepath pg_subnets_ips.yaml

