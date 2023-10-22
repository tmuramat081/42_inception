#!/bin/bash
set -eo pipefail

setup_rndc_key() {
	rndc-confgen -a -b 512 -k rndc-key
	chmod 755 /etc/bind/rndc.key
}

_main() {
	echo "bind start"
	if [ ! -f /etc/bind/rndc.key ]; then
		setup_rndc_key
	else
		echo "rndc.key already exists, skipping config creation."
	fi
	envsubst '$DOMAIN_NAME,$IP_HOST' < /etc/bind/named.conf.template > /etc/bind/named.conf
	envsubst '$DOMAIN_NAME,$IP_HOST' < /etc/bind/named.zone.template > /etc/bind/named.zone
	mkdir -p /run/named/
	chown bind:bind /run/named/
	echo "dns installed";
	exec "$@"
}

_main "$@"