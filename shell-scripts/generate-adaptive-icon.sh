#!/bin/sh

usage="Usage: $0 INPUT_FILE OUTPUT_FILE"

if [[ -z "$1" ]] || [[ -z "$2" ]]; then
  echo "$usage"
  exit 1
fi

ffmpeg -i "$1" -vf 'format=rgba,pad=iw*1.5:ih*1.5:iw/4:ih/4:color=#00000000' "$2"
