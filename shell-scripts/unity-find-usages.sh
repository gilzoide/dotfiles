#!/bin/sh

# Find usages of Unity assets based on their GUID.
# Needs `rg` (ripgrep) to be installed and on PATH.

script_usage="Usage: $0 FILE_PATH [...]"

if [[ -z "$1" ]]; then
  echo "Expected file path"
  echo "$script_usage"
  exit 1
fi
if [[ ! -f "$1" ]]; then
  echo "No such file: '$1'"
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

guid=$(cat "$file_path" | grep -m 1 guid: | cut -w -f2)
if [[ -z "$guid" ]]; then
  echo "Couldn't find GUID for file '$file_path'"
  exit 1
fi
rg "$guid" --glob "!$file_path" $rg_args
