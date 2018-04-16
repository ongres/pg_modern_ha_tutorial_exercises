#!/bin/bash


basepath=`dirname $0`
source $basepath/functions/image-step.sh

[ $# -eq 1 ] || error "Missing parameter: project name" $0

deploymentName=dm-07-postgres-image
deploymentTemplate=postgres-image_generation.yaml
zone=europe-west1-b
playbook=postgres.yml
instanceName=vm-pg-image-generation
baseImageName=img-pg-base-img-ubuntu-base
image_name=$baseImageName

create_image_from $1 $deploymentName $deploymentTemplate $zone $playbook $instanceName $image_name  

echo $image_name
