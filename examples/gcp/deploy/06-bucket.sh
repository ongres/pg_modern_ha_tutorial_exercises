#!/bin/bash


basepath=`dirname $0`
source $basepath/functions/deployment-manager.sh


[ $# -eq 2 ] || error "Missing parameter: project name (prep|prod)" $0
[ $2 = "prep" ] || [ $2 = "prod" ] || error "Invalid environment parameter (prep|prod)" $0


deploymentName=dm-06-$2-bucket
deploymentTemplate=bucket-$2.yaml

create_deployment $1 $deploymentName $basepath $deploymentTemplate 
