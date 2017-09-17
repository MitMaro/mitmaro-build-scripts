
include_path="$PWD"

set-include-path() {
	include_path="$1"
}

include () {
	if [[ ! -f "${include_path}/$*" ]]; then
		error "Error including $*" "$EXIT_CODE_INCLUDE_ERROR"
	fi

	# shellcheck disable=SC1090
	source "${include_path}/$*"
}
