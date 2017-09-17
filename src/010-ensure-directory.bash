ensure-directory() {
	if [[ ! -d "${1}" ]]; then
		info "directory ${1} missing; creating"
		mkdir -p "${1}/"
	fi
}
