#!/bin/bash

if [[ -z "$1" ]]; then
	FQDN=$(grep -E -- '^search|^domain' /etc/resolv.conf | cut -d' ' -f2 | sort -u)
	if [[ -z "$FQDN" ]]; then
		echo "No domain found in /etc/resolv.conf, please provide one"
		exit 1
	fi
	
	echo "Using $FQDN found in /etc/resolv.conf"
	echo "Domain controllers for $FQDN"
	dig +short any _kerberos._tcp.$FQDN
	
	echo .
	echo "Primary DC"
	dig +short any _ldap._tcp.pdc._msdcs.$FQDN
	
	echo .
	echo "Global Catalog (GC)"
	dig +short any _gc._tcp.$FQDN

else
	echo "Using $1 for query"
	echo "DCs for $1"
	dig +short any _kerberos._tcp.$1
	
	echo .
	echo "Primary Domain Controller (PDC)"
	dig +short any _ldap._tcp.pdc._msdcs.$1
	
	echo .
	echo "Global Catalog (GC)"
	dig +short any _gc._tcp.$1
fi