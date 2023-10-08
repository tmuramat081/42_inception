#!/bin/bash
set -eo pipefail

_main() {
	echo "dns installed";
	exec "$@"
}

_main "$@"