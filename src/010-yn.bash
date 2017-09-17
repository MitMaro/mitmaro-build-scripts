
yn() {
	local value
	value="$(tr '[:upper:]' '[:lower:]' <<< "$1")"
	case "${value}" in
		y|yes|true|1) true ;;
		*) false ;;
	esac
}
