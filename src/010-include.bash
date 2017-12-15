
__mm_include_path="$PWD"

include () {
	if [[ ! -f "${__mm_include_path}/$*" ]]; then
		error "Error including $*" "$EXIT_CODE_INCLUDE_ERROR"
	fi

	# shellcheck disable=SC1090
	source "${__mm_include_path}/$*"
}

set-include-path() {
	__mm_include_path="$1"
}
