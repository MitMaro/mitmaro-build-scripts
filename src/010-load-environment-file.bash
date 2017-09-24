
load-environment-file() {
	set -a
	if [[ -e "$1" ]]; then
		eval "$(
			awk '
			function ltrim(s) { sub(/^[[:space:]]+/, "", s); return s }
			BEGIN {
				FS="="
				last=""
			}
			/^([[:space:]]*[a-zA-Z_]+[a-zA-Z0-9_]*)=(.*)$/ {
				rest = substr($0, index($0, "=") + 1);
				name = ltrim($1)
				print last
				print "local MM__" name "=" rest
				last = $1 "=\"${"name"=\"$MM__" name "\"}\"";
				next
			}
			{print $0}
			END {print last}
			' "$1"
		)"
	fi
	set +a
}
