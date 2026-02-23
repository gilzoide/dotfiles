#!/bin/sh
USAGE="Usage: $0 GITLAB_REPO_URL"

if [[ -z "$1" ]]; then
  echo $USAGE
  exit 1
fi
glab securefile list -R "$1" | jq '.[] | {id, name}'
