
init-node() {
	cd "$(get-project-root "node")" || fatal "Unable to change to project root"
	export PATH=$PATH:"${PWD}/node_modules/.bin/"
}
