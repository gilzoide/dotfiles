#!/bin/sh

script_usage="Usage: $0 GRADLE_SCRIPT KEYSTORE_PASSWORD [KEY_PASSWORD]"

if [[ -z "$1" ]]; then
  echo "Expected gradle script path"
  echo "$script_usage"
  exit 1
fi
gradle_script_path="$1"

if [[ ! -f "$gradle_script_path" ]]; then
  echo "Given gradle script path '$gradle_script_path' does not exist!"
  exit 2
fi

if [[ -z "$2" ]]; then
  echo "Expected keystore password"
  echo "$script_usage"
  exit 1
fi
store_password="$2"

key_password="$3"
if [[ -z "$key_password" ]]; then
  key_password="$store_password"
fi

sed -i .bkp "s/storePassword.*/storePassword '$store_password'/;s/keyPassword.*/keyPassword '$key_password'/" "$gradle_script_path"
