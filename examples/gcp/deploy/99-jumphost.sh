#!/bin/bash

basepath=`dirname $0`
source $basepath/functions/deployment-manager.sh


[ $# -eq 2 ] || error "Missing parameter: project name (prep|prod)" $0
[ $2 = "prep" ] || [ $2 = "prod" ] || error "Invalid environment parameter (prep|prod)" $0

deploymentName=dm-99-$2-jumphost
deploymentTemplate=jumphost-$2.yaml

create_deployment_if_not_exists $1 $deploymentName $basepath $deploymentTemplate 

