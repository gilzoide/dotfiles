#!/bin/sh

# This script lists all dinamic libraries from .framework / .xcframework, searching recursively inside the current folder
# Use this inside Pods folder to check which libraries should be embedded in your XCode targets
find . -type f ! -name "*.*" | xargs file | grep Mach-O | grep dynamically | cut -w -f 1 | cut -d ':' -f 1 | uniq | sort
