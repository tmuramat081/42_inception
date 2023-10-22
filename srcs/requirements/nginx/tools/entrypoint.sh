#!/bin/bash
set -eo pipefail

_main() {
	envsubst '$DOMAIN_NAME' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
	exec "$@"
}

_main "$@"