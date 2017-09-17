

C_LOG_DATE="${COLOR_DIM}${COLOR_CYAN}"
C_DEBUG="${COLOR_DIM}"
C_WARNING="${COLOR_BOLD}${COLOR_YELLOW}"
C_ERROR="${COLOR_BOLD}${COLOR_RED}"

_message() {
	local prefix
	prefix="[${C_LOG_DATE}$(date '+%Y/%m/%d %H:%M:%S')${COLOR_RESET}]"
	printf "%b\\n" "${prefix} $*"
}

hl() {
	local error_code="$?"
	echo "${COLOR_STANDOUT}$*${COLOR_REMOVE_STANDOUT}"
	return "$error_code"
}

debug() {
	_message "${C_DEBUG}[DEBUG]${COLOR_RESET} $*"
}

info() {
	_message "[INFO] $*"
}

warn() {
	_message "${C_WARNING}[WARN]${COLOR_RESET} $*"
}

error() {
	>&2 _message "${C_ERROR}[ERROR]${COLOR_RESET} $*"
}

fatal() {
	# use error code provided if set, else last command's error code
	local err=${2-$?}

	>&2 _message "${C_ERROR}[FATAL]${COLOR_RESET} ${1}"

	if [[ ! -z ${err} ]]; then
		exit "${err}"
	fi
}
