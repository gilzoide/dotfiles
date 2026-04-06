#!/bin/sh

if [[ -z "$1" ]]; then
  echo "Usage: $0 ROOT_GROUP"
  exit 1
fi

ROOT_GROUP="$1"
glab repo list -g "$ROOT_GROUP" -G -P 999 \
  | grep "$ROOT_GROUP" \
  | cut -f 1 \
  | while read -r repo; do
    dir=$(basename "$repo")
    if [ ! -d "$dir" ]; then
      echo "Cloning $repo ..."
      glab repo clone "$repo"
    else
      echo "Skipping $repo (already exists)"
    fi
  done