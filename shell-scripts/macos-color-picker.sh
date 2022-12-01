#!/bin/sh

# Launch a macOS color picker and copy the result to clipboard
# Result is in the format RRGGBB using hexadecimal digits (HTML style)

rgb=$(osascript -e 'choose color')

red_raw=$(echo "$rgb" | cut -d ',' -f 1)
green_raw=$(echo "$rgb" | cut -d ',' -f 2)
blue_raw=$(echo "$rgb" | cut -d ',' -f 3)

red=$(echo "$red_raw / 256" | bc)
green=$(echo "$green_raw / 256" | bc)
blue=$(echo "$blue_raw / 256" | bc)

html_color=$(printf '%02x%02x%02x' "$red" "$green" "$blue")
echo "$html_color"
printf "%s" "$html_color" | pbcopy
