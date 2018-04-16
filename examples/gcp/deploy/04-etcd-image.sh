#!/bin/bash


basepath=`dirname $0`
source $basepath/functions/image-step.sh


[ $# -eq 1 ] || error "Missing parameter: project name" $0


deploymentName=dm-04-etcd-image
deploymentTemplate=etcd-image_generation.yaml
zone=europe-west1-b
playbook=etcd.yml
instanceName=vm-etcd-image-generation
baseImageName=img-etcd-base-img-ubuntu-base


#current_date=`date_for_printing`
#image_name=$baseImageName-$current_date
image_name=$baseImageName

create_image_from $1 $deploymentName $deploymentTemplate $zone $playbook $instanceName $image_name

echo $image_name
