#!/bin/bash

#
# This script creates the service account for wale storage API. keys
# Even tho keys are created in the DM, are not working as the command does not
# output the keys for download.
# Keys can be created through UI, downloaded and sent to the nodes (/etc/wal-e.d/env/key).
# C&P does not work as it breaks the file.
# Once service account is created, it needs full storage.buckets.* permissions. This can be
# set through roles, although there is no property to link SA with roles at DM API.


basepath=`dirname $0`
source $basepath/functions/deployment-manager.sh


[ $# -eq 2 ] || error "Missing parameter: project name (prep|prod)" $0
[ $2 = "prep" ] || [ $2 = "prod" ] || error "Invalid environment parameter (prep|prod)" $0


deploymentName=dm-97-$2-serviceaccount
deploymentTemplate=serviceaccount-$2.yaml

create_deployment $1 $deploymentName $basepath $deploymentTemplate 
