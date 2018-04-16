
function error() {
	echo "$1" >&2
	echo -e "$2" >&2
	exit 1
}

function retry() {
	timesToRetry=$1
	secondsToRetry=$2
	error_msg="$3"
	error_pointer=$4
	shift 4
	echo retry

	for (( i = 0; i < $timesToRetry; i++ )); do
		"$@"
		status=$?
		if [[ $status -eq 0 ]]; then
			break
		fi
		sleep $secondsToRetry
	done
	if [[ $status -ne 0 ]]; then
		error $error_msg $error_pointer
	fi	
}

function rethrow_if_error () {
	
	error_msg=$1
	error_pointer=$2
	shift 2

	"$@"
	status=$?
	if [[ $status -ne 0 ]]; then
		error $error_msg $error_pointer
	fi
}

function rethrow_if_no_error () {
	error_msg=$1
	error_pointer=$2
	shift 2

	"$@"
	status=$?
	if [[ $status -eq 0 ]]; then
		error $error_msg $error_pointer
	fi	
}
