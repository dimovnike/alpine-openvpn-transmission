#!/bin/sh

set -e 

# allow transmission access from inside
iptables -A INPUT  -i eth0 -p tcp --dport 9091 -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 9091 -m state --state ESTABLISHED,RELATED -j ACCEPT

# check if config is present an if not, create it
# we use this layout
# /var/lib/transmission/torrents - for torrent files
# /var/lib/transmission/settings.json - for config
# /var/lib/transmission/downloads - for download

[ -d /var/lib/transmission/downloads ] || mkdir -p /var/lib/transmission/downloads

[ -f /var/lib/transmission/settings.json ] || {
	echo Creating new config file for transmission
	transmission-daemon -d  2>/tmp/tempconf # sed doesnt work here directly
	cat /tmp/tempconf | sed -e 's~"\(download\|incomplete\)-dir":.*$~"\1-dir": "/var/lib/transmission/downloads",~; ' > /var/lib/transmission/settings.json
}

/usr/bin/transmission-daemon -f -g /var/lib/transmission/

# if transmission dies - kill the container/supervisor
kill 1
