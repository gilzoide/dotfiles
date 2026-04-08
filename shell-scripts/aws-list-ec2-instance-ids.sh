#!/bin/sh
NAME_PATTERN="$1"
if [[ -z "$NAME_PATTERN" ]]; then
  echo "USAGE: $0 NAME_PATTERN"
  exit 1
fi

aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$NAME_PATTERN" \
    --query "Reservations[*].Instances[*].{InstanceId:InstanceId}" \
    --output json \
  | jq '.[].[].InstanceId' -r