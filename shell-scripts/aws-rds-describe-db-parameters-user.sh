#!/bin/sh
DB_PARAMETER_GROUP_NAME="$1"
if [[ -z "$DB_PARAMETER_GROUP_NAME" ]]; then
  echo "USAGE: $0 DB_PARAMETER_GROUP_NAME"
  exit 1
fi

aws rds describe-db-parameters \
    --db-parameter-group-name "$DB_PARAMETER_GROUP_NAME" \
    --source user \
    --query 'Parameters[*].{Name:ParameterName,Value:ParameterValue,ApplyMethod:ApplyMethod}' \
    --output table
