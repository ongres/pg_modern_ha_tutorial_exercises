#!/bin/bash


basepath=`dirname $0`
source $basepath/functions/image-step.sh


[ $# -eq 1 ] || error "Missing parameter: project name" $0


deploymentName=dm-03-ubuntu-image
deploymentTemplate=ubuntu-image_generation.yaml
zone=europe-west1-b
playbook=ubuntu.yml
instanceName=vm-image-generation
baseImageName=img-ubuntu-base-ubuntu-1604-xenial-v20171208

#current_date=`date_for_printing`
#image_name=$baseImageName-$current_date
image_name=$baseImageName
create_image_from $1 $deploymentName $deploymentTemplate $zone $playbook $instanceName $image_name

echo $image_name
