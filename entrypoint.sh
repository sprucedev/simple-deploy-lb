#!/bin/bash

INIT="/etc/init.d/haproxy"
CONF_PATH="/etc/haproxy/haproxy.cfg"
CONF_D="$CONF_PATH.d"

export HOST_RE='sdeploy-'

function regenerate {
  for filename in $(ls "$CONF_D"); do
    "$CONF_D/$filename"
  done
}

regenerate > "$CONF_PATH"
$INIT start

while true; do
  inotifywait -e close_write /etc/hosts
  regenerate > "$CONF_PATH"
  $INIT reload
done
