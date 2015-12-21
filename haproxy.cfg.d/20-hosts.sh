#!/bin/bash
while read line; do
  OIFS="$IFS"
  IFS=" 	#"
  line_part=($line)
  if [[ -n "${line_part[0]}" ]]; then
    if [[ "${line_part[1]}" =~ "$HOST_RE" ]]; then
      echo "    server ${line_part[1]} ${line_part[0]}:5000 check"
    fi
  fi
  IFS="$OIFS"
done < /etc/hosts
