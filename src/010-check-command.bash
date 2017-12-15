
check-command() {
	if ! command -v "$1" > /dev/null; then
		fatal "Command $(hl "$1") not found" "$EXIT_CODE_INVALID_STATE"
	fi
	debug "Command $(hl "$1") found"
}
