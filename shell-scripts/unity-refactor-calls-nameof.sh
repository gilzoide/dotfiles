#!/bin/sh

# Update calls to the following using string literals to use `nameof` instead:
# StartCoroutine, StopCoroutine, CancelInvoke, Invoke, InvokeRepeating, IsInvoking

# Methods taking a single string as argument
target_methods_1='StartCoroutine|StopCoroutine|CancelInvoke|IsInvoking'
# Methods taking more than a single string as argument
target_methods_2='Invoke|InvokeRepeating'

spaces_re='[ \\t\\n]*'
sed_script_1="s/($target_methods_1)$spaces_re\($spaces_re\"([a-zA-Z0-9]+)\"$spaces_re\)/\1(nameof(\2))/"
sed_script_2="s/($target_methods_2)$spaces_re\($spaces_re\"([a-zA-Z0-9]+)\"$spaces_re,/\1(nameof(\2),/"

# echo $sed_script_1
# exit

affected_scripts=$(rg "($target_methods_1|$target_methods_2)$spaces_re\($spaces_re\"" -l)
echo "$affected_scripts" | while read script; do
  sed -i '' -E -e "$sed_script_1" -e "$sed_script_2" "$script"
done