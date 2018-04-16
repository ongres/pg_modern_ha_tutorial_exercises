source `dirname $0`/functions/errors.sh

ANSIBLE_DEPLOY_REL_FOLDER=../vm-images/ansible

function runPlaybook() {
	natIP=$1
	playbook=$2
	ansibleFolder=$3/$ANSIBLE_DEPLOY_REL_FOLDER
	userName=$(whoami)

	(
		cd $ansibleFolder

		echo "Waiting for instance to be SSH-able..."
		
		retry 10 3 "$natIP unreachable to ansible" $0 ansible all -m ping -i "$natIP," >/dev/null 2>&1
        
		echo "Running playbook"
  	    ANSIBLE_CONFIG=$ansibleFolder/ansible.cfg ansible-playbook -i "$natIP," $playbook -u $userName 
	)
}

