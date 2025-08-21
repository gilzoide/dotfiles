#!/bin/sh

if [[ -z "$1" ]]; then
  echo "Usage: generate-gradlew.sh GRADLE_VERSION"
  exit 1
fi

touch empty.gradle
gradle wrapper --build-file empty.gradle --no-daemon --gradle-version $1
rm empty.gradle
