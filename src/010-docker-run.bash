
docker-run() {
	local image
	image="$1"
	shift

	if ! yn "${MM_NO_DOCKER-}" && command -v "docker" &> /dev/null; then
		docker run --rm -v "$PWD:/project" -w "/project" "$image" "$@"
	else
		"$@"
	fi
}

#docker-copy() {
#	local containername
#	local path
#
#	if ! yn "${MM_NO_DOCKER-}" && command -v "docker" &> /dev/null; then
#		containername="$1"
#		path="$2"
#		docker cp "$path" "$containername":"$path"
#	fi
#}
#
#docker-exec() {
#	local containername
#	local user
#
#	user=
#	if [[ -n "$MM_DOCKER_USER" ]]; then
#		user="-u $MMDOCKER_USER"
#	fi
#	containername="$1"
#	shift
#
#	if ! yn "${MM_NO_DOCKER-}" && command -v "docker" &> /dev/null; then
#		docker exec "$containername" "${user}" "$@"
#	else
#		"$@"
#	fi
#}
