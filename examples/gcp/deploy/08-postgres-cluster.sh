#!/bin/bash


basepath=`dirname $0`
source $basepath/functions/deployment-manager.sh


[ $# -eq 2 ] || error "Missing parameter: project name (prep|prod)" $0
[ $2 = "prep" ] || [ $2 = "prod" ] || error "Invalid environment parameter (prep|prod)" $0


create_deployment $1 dm-08-$2-postgres-cluster $basepath postgres-cluster-$2.yaml
