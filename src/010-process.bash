
__mm-process-exit-trap() {
	info "Removing PID file"
	rm -f "$2"
}

__mm-kill-process-trap() {
	message "Caught SIGTERM signal, shutting down process"
	kill -TERM "$(cat "$1")"
}

__mm-create-lock-file() {
	local counter
	local lock_file_name

	lock_file_name="$1"
	counter=0
	debug "Waiting on lock file: $lock_file_name"
	set -o noclobber
	#shellcheck disable=SC2188
	while ! { > "$lock_file_name"; } &> /dev/null; do
		sleep 0.1
		((++counter))

		if [[ "${counter}" -gt "100" ]]; then
			fatal "$(hl "$lock_file_name") already exists, cannot continue"
			set +o noclobber
		fi
	done
	set +o noclobber

	debug "Created lock file: $lock_file_name"
}

process-run() {
	local command
	local lock_file_name
	local name
	local pid_file_name
	local process_pid
	local temp_directory

	command="$1"
	name="$2"
	temp_directory="$3"
	pid_file_name="$temp_directory/mm-build-$name.pid"
	lock_file_name="$temp_directory/mm-build-$name.lock"
	shift 3

	debug "lock-file-start"
	__mm-create-lock-file "${lock_file_name}"
	debug "lock-file-after"
	shutdown-process "${pid_file_name}"
	debug "shutdown after"

	#shellcheck disable=SC2064
	trap "__mm-kill-process-trap ${pid_file_name}" TERM

	# wrap in subshell so that traps are caught correctly
	(
		#shellcheck disable=SC2064
		trap "__mm-process-exit-trap ${lock_file_name} ${pid_file_name}" EXIT
		${command} "$@" &
		process_pid=$!
		info "Process started (pid=${process_pid})"
		set -o noclobber
		echo "${process_pid}" > "${pid_file_name}"
		set +o noclobber
		# call this after the wait call (kinda)
		(sleep 1 && rm -f "${lock_file_name}") &
		wait "${process_pid}"
	) &
	wait
}

shutdown-process() {
	local counter
	local pid
	local pid_file

	pid_file="$1"
	if [[ -e "${pid_file}" ]]; then
		read -r pid < "${pid_file}"
		if kill -s 0 "$pid" &> /dev/null; then
			warn "Shutting down existing process with pid=$(hl "$pid")"
			kill -TERM "$pid"
			counter=0
			while kill -s 0 "$pid" &> /dev/null; do
				((++counter))
				sleep 0.1
				if [[ "${counter}" -gt "100" ]]; then
					fatal "Process with pid=$(hl "pid") could not be shutdown"
				fi
			done
			info "Process stopped"
		else
			warn "Process referenced in $(hl "$pid_file") doesn't exist; deleting file"
			rm -f "$pid_file"
		fi
	fi
}
