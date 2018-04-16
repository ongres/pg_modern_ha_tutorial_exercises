source `dirname $0`/functions/errors.sh


function get_gcloud() {
	gcloud=`which gcloud`
	[ $? -eq 0 ] || error "Cannot find gcloud binary" $0

	echo $gcloud
}


DM_PATH_REL_DEPLOY_DIR=../infrastructure/deployment-manager

function create_deployment() {
	gcloud=`get_gcloud`

	exists=$($gcloud --project $1 deployment-manager deployments describe $2 2>&1 >/dev/null | grep ERROR)
	if [ -z "$exists" ]; then    
		error "Error: deployment $2 already exists" $0
	fi

	$gcloud --project $1 deployment-manager deployments create $2 --config $3/$DM_PATH_REL_DEPLOY_DIR/$4

	echo -e "\nTo delete deployment execute:\n\\n\tgcloud deployment-manager deployments delete $2\n"
}

function create_deployment_if_not_exists() {
	gcloud=`get_gcloud`

	exists=$($gcloud --project $1 deployment-manager deployments describe $2 2>&1 >/dev/null | grep ERROR)
	if [ -n "$exists" ]; then    
		$gcloud --project $1 deployment-manager deployments create $2 --config $3/$DM_PATH_REL_DEPLOY_DIR/$4
	fi

	echo -e "\nTo delete deployment execute:\n\\n\tgcloud deployment-manager deployments delete $2\n"
}

function delete_deployment() {
	gcloud=`get_gcloud`

	exists=$($gcloud --project $1 deployment-manager deployments describe $2 2>&1 >/dev/null | grep ERROR)
	if [ -n "$exists" ]; then    
		error "Error: deployment $2 doesn't exist" $0
	fi

	$gcloud --project $1 deployment-manager deployments delete $2 -q

}


function get_public_ip() {
	gcloud=`get_gcloud`
	natIP=$(gcloud --project $1 compute instances describe $2 --zone $3 | grep natIP | awk -F ' ' '{print $2}')
	echo $natIP
}

function stop_instance() {
	gcloud=`get_gcloud`
	$gcloud --project $1 compute instances stop $2 --zone $3 
}

function create_image() {

	image_name=$2
	instance=$3
	zone=$4

	gcloud=`get_gcloud`

	exists=$($gcloud --project $1 compute images describe $image_name 2>&1 >/dev/null | grep ERROR)
	if [ -z "$exists" ]; then    
		gcloud compute images delete $image_name -q
	fi
	
	gcloud --project $1 compute images create $image_name --source-disk dsk-$instance-boot --source-disk-zone $zone
}


