# shellcheck disable=SC2034

if type tput >& /dev/null && tput colors >& /dev/null; then
	COLOR_RESET="$(tput sgr0)"
	COLOR_BOLD="$(tput bold)"
	COLOR_DIM="$(tput dim)"
	COLOR_UNDERLINE="$(tput smul)"
	COLOR_REMOVE_UNDERLINE="$(tput rmul)"
	COLOR_REVERSE="$(tput rev)"
	COLOR_STANDOUT="$(tput smso)"
	COLOR_REMOVE_STANDOUT="$(tput rmso)"
	COLOR_BLACK="$(tput setaf 0)"
	COLOR_RED="$(tput setaf 1)"
	COLOR_GREEN="$(tput setaf 2)"
	COLOR_YELLOW="$(tput setaf 3)"
	COLOR_BLUE="$(tput setaf 4)"
	COLOR_MAGENTA="$(tput setaf 5)"
	COLOR_CYAN="$(tput setaf 6)"
	COLOR_WHITE="$(tput setaf 7)"
	BG_BLACK="$(tput setab 0)"
	BG_RED="$(tput setab 1)"
	BG_GREEN="$(tput setab 2)"
	BG_YELLOW="$(tput setab 3)"
	BG_BLUE="$(tput setab 4)"
	BG_MAGENTA="$(tput setab 5)"
	BG_CYAN="$(tput setab 6)"
	BG_WHITE="$(tput setab 7)"
else
	COLOR_RESET=
	COLOR_BOLD=
	COLOR_DIM=
	COLOR_UNDERLINE=
	COLOR_REMOVE_UNDERLINE=
	COLOR_REVERSE=
	COLOR_STANDOUT=
	COLOR_REMOVE_STANDOUT=
	COLOR_BLACK=
	COLOR_RED=
	COLOR_GREEN=
	COLOR_YELLOW=
	COLOR_BLUE=
	COLOR_MAGENTA=
	COLOR_CYAN=
	COLOR_WHITE=
	BG_BLACK=
	BG_RED=
	BG_GREEN=
	BG_YELLOW=
	BG_BLUE=
	BG_MAGENTA=
	BG_CYAN=
	BG_WHITE=
fi
