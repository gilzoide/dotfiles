#!/bin/sh
## Usage: unity-refactor-calls-nameof.sh [FILES...]

# Update calls to the following using string literals to use `nameof` instead:
#   StartCoroutine, StopCoroutine, CancelInvoke, Invoke, InvokeRepeating, IsInvoking
# If no file names are passed, uses `rg` to search for all **.cs scripts that need update

# Methods taking a single string as argument
target_methods_1='StartCoroutine|StopCoroutine|CancelInvoke|IsInvoking'
# Methods taking more than a single string as argument
target_methods_2='Invoke|InvokeRepeating'

spaces_re='[ \\t\\n]*'

if [[ $# -eq 0 ]]; then
  affected_scripts=$(rg "($target_methods_1|$target_methods_2)$spaces_re\($spaces_re\"" --glob '**.cs' -l)
else
  affected_scripts="$@"
fi

sed_script_1="s/($target_methods_1)$spaces_re\($spaces_re\"([a-zA-Z0-9]+)\"$spaces_re\)/\1(nameof(\2))/"
sed_script_2="s/($target_methods_2)$spaces_re\($spaces_re\"([a-zA-Z0-9]+)\"$spaces_re,/\1(nameof(\2),/"

echo "$affected_scripts" | while read script; do
  sed -i '' -E -e "$sed_script_1" -e "$sed_script_2" "$script"
done