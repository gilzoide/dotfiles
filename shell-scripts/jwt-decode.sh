#!/bin/sh
# Decode a JWT's header and payload. Does not perform any signature verification.

USAGE="Usage: $0 ENCODED_JWT"
if [[ -z "$1" ]]; then
  echo "$USAGE"
  exit 1
fi

echo "$1" | jq -R 'split(".") | .[0:2] | map(gsub("-"; "+") | gsub("_"; "/") | @base64d) | map(fromjson)'
