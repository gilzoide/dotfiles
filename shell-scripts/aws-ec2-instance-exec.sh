#!/bin/sh
NAME_PATTERN="$1"
shift
COMMAND="$@"
if [[ -z "$NAME_PATTERN" ]] || [[ -z "$COMMAND" ]]; then
  echo "USAGE: $0 NAME_PATTERN COMMAND..."
  exit 1
fi


instance_ids=$(aws-list-ec2-instance-ids.sh "$NAME_PATTERN")
instance_ids_spaced=$(echo "$instance_ids" | tr '\n' ' ')
echo "Instance IDs: $instance_ids_spaced"

command_info=$(
  aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --instance-ids $instance_ids_spaced \
    --parameters "commands=$COMMAND" \
    --output json
)
command_id=$(echo $command_info | jq '.Command.CommandId' -r)
echo "Command ID: $command_id"
echo "$instance_ids" | while read -r instance_id; do
    aws ssm wait command-executed --command-id "$command_id" --instance-id "$instance_id"
    command_output=$(aws ssm get-command-invocation --command-id "$command_id" --instance-id "$instance_id" --output json | jq '.StandardOutputContent' -r)
    echo "[$instance_id] $command_output"
    echo
done