#!/bin/sh

file="$1"
if [[ -z "$file" ]]; then
  file=".vscode/settings.json"
fi

sed_script='
# Add "omnisharp.useModernNet": false
/[ \t]}$/ s/([ \t]+)}/\1},\n\1"omnisharp.useModernNet": false/

## Delete some file exclusions:
# Useful folders
/[Bb]uild|[Ll]ibrary|[Pp]rojectSettings/d
# Git stuff
/gitignore|gitmodules/d
# Any other project files, but .meta
/\.meta/! {
  /\*\./d
}
'
sed -i .bkp -E -e "$sed_script" "$file"