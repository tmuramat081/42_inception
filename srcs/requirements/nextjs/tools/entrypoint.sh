#!/bin/bash
set -eu -o pipefail

setup_nextjs() {
	npx create-next-app my-next-app
	cd my-next-app
	npm run build
}

_main() {
	echo "nextjs start"
	setup_nextjs
	echo "nextjs installed";
	cd my-next-app
	exec "$@"
}

_main "$@"
