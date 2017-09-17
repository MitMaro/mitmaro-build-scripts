
function get-project-root() {
	local project_file
	case "${1-""}" in
	'node')
		project_file='package.json'
		;;
	"")
		fatal "No project type passed to $(hl get-project-root)" "${EXIT_CODE_INVALID_STATE}"
		;;
	*)
		fatal "Invalid project type passed to $(hl get-project-root)" "${EXIT_CODE_INVALID_STATE}"
		;;
	esac

	# traverse parents until project root is found
	project_root=
	path="$PWD"
	while [[ "$path" != "/" ]]; do
		if [[ -f "$path/$project_file" ]]; then
			project_root="$path"
			break;
		else
			path="$(dirname "$path")"
		fi
	done
	if [[ -z "$project_root" ]]; then
		error "Project root could not be found"
		return 1
	fi
	printf "%s" "$project_root"
	return 0
}
