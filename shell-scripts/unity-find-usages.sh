#!/bin/sh

# Find usages of Unity assets based on their GUID.
# Needs `rg` (ripgrep) to be installed and on PATH.

script_usage="Usage: $0 FILE_PATH [...]"

if [[ -z "$1" ]]; then
  echo "Expected file path"
  echo "$script_usage"
  exit 1
fi
file_path="$1"
shift

if [[ $file_path != *.meta ]]; then
  file_path="$file_path.meta"
fi

if [[ $# -eq 0 ]]; then
  rg_args="-c"
else
  rg_args=$@
fi

guid=$(cat "$file_path" | grep guid: | cut -w -f2)
rg "$guid" --glob "!$file_path" $rg_args