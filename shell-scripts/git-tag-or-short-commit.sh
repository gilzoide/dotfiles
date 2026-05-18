#!/bin/sh
git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD