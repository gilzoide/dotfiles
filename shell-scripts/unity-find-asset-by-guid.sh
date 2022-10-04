#!/bin/sh

usage="Usage: $0 GUID"

if [[ -z "$1" ]]; then
    echo "$usage"
    exit 1
fi

rg --glob '*.meta' -l $1