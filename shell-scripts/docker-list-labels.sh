#!/bin/sh
if [[ -z "$1" ]]; then
  echo "USAGE: $0 IMAGE"
  exit 1
fi

docker inspect --format='{{json .Config.Labels}}' $@