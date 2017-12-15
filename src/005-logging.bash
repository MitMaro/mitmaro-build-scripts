
C_LOG_DATE="${COLOR_DIM}${COLOR_CYAN}"
C_DEBUG="${COLOR_DIM}"
C_WARNING="${COLOR_BOLD}${COLOR_YELLOW}"
C_ERROR="${COLOR_BOLD}${COLOR_RED}"

__mm_log_level_debug=0
__mm_log_level_info=1
__mm_log_level_warn=2
__mm_log_level_error=3
__mm_log_level_fatal=4

__mm_log_level=
__mm_output_log_name=

set-log-level() {
	case "${1-info}" in
		"debug") __mm_log_level="$__mm_log_level_debug" ;;
		"info") __mm_log_level="$__mm_log_level_info" ;;
		"warn") __mm_log_level="$__mm_log_level_warn" ;;
		"error") __mm_log_level="$__mm_log_level_error" ;;
		"fatal") __mm_log_level="$__mm_log_level_fatal" ;;
		*) __mm_log_level="$__mm_log_level_info" ;;
	esac
}

set-log-level "${MM_LOG_LEVEL:-info}"

set-log-name() {
	__mm_output_log_name="[$1] "
}

clear-log-name() {
	__mm_output_log_name=
}

_message() {
	local prefix
	prefix="$__mm_output_log_name[${C_LOG_DATE}$(date '+%Y/%m/%d %H:%M:%S')${COLOR_RESET}]"
	printf "%b\\n" "${prefix} $*"
}

hl() {
	local error_code="$?"
	echo "${COLOR_UNDERLINE}$*${COLOR_REMOVE_UNDERLINE}"
	return "$error_code"
}

debug() {
	if [[ "${__mm_log_level}" -gt "${__mm_log_level_debug}" ]]; then
		return
	fi
	_message "${C_DEBUG}[DEBUG]${COLOR_RESET} $*"
}

info() {
	if [[ "${__mm_log_level}" -gt "${__mm_log_level_info}" ]]; then
		return
	fi
	_message "[INFO] $*"
}

warn() {
	if [[ "${__mm_log_level}" -gt "${__mm_log_level_warn}" ]]; then
		return
	fi
	_message "${C_WARNING}[WARN]${COLOR_RESET} $*"
}

error() {
	if [[ "${__mm_log_level}" -gt "${__mm_log_level_error}" ]]; then
		return
	fi
	>&2 _message "${C_ERROR}[ERROR]${COLOR_RESET} $*"
}

fatal() {
	# use error code provided if set, else last command's error code
	local err=${2-$?}

	if [[ "${__mm_log_level}" -gt "${__mm_log_level_fatal}" ]]; then
		return
	fi

	>&2 _message "${C_ERROR}[FATAL]${COLOR_RESET} ${1}"

	if [[ ! -z ${err} ]]; then
		exit "${err}"
	fi
}
