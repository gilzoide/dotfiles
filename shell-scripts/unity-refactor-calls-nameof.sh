#!/bin/sh
## Usage: unity-refactor-calls-nameof.sh [FILES...]

# Update calls to the following using string literals to use `nameof` instead:
#   StartCoroutine, StopCoroutine, CancelInvoke, Invoke, InvokeRepeating, IsInvoking
# If no file names are passed, uses `rg` to search for all **.cs scripts that need update

target_methods='StartCoroutine|StopCoroutine|CancelInvoke|Invoke|InvokeRepeating|IsInvoking'
spaces_re="[	 ]*"
search_re="^$spaces_re($target_methods)$spaces_re\($spaces_re\""

if [[ $# -eq 0 ]]; then
  affected_scripts=$(rg "$search_re" --glob '**.cs' -l)
else
  while [[ $# -gt 0 ]]; do
    affected_scripts=$(printf "%s\n%s" "$1" "$affected_scripts")
    shift
  done
fi

sed_script="
/$search_re/ {
  s/\"([a-zA-Z0-9]+)\"/nameof(\1)/
}
"

echo "$affected_scripts" | while read script; do
  if [[ ! -z "$script" ]]; then
    sed -i '' -E -e "$sed_script" "$script"
  fi
done
