#!/bin/bash

HAPROXY="/usr/sbin/haproxy"
CONF_PATH="/etc/haproxy/haproxy.cfg"
CONF_D="$CONF_PATH.d"
PIDFILE="/var/run/haproxy.pid"

export HOST_RE='simple-deploy-'

function regenerate {
  for filename in $(ls "$CONF_D"); do
    "$CONF_D/$filename"
  done
}

regenerate > "$CONF_PATH"
$HAPROXY -D -f "$CONF_PATH" -p "$PIDFILE"

while true; do
  inotifywait -e close_write /etc/hosts
  regenerate > "$CONF_PATH"
  kill -s SIGHUP "$(cat "$PIDFILE")"
done
