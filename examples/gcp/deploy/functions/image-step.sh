#!/bin/bash


basepath=`dirname $0`
source $basepath/functions/deployment-manager.sh
source $basepath/functions/ansible-helper.sh
source $basepath/functions/dates.sh

function create_image_from() {
	deploymentName=$2
	deploymentTemplate=$3
	zone=$4
	playbook=$5
	instanceName=$6
	imageName=$7
	stop=$8
	

	create_deployment $1 $deploymentName $basepath $deploymentTemplate 
	ip=$(get_public_ip $1 $instanceName $zone)

	runPlaybook $ip $playbook $basepath

	if [[ -n $stop ]]; then
		exit 0
	fi

	stop_instance $1 $instanceName $zone

	create_image $1 $imageName $instanceName $zone

	delete_deployment $1 $deploymentName
}
