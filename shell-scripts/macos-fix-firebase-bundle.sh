#!/opt/homebrew/bin/fish

sed -i '' -e 's/CPU: AnyCPU/CPU: x86_64/' **/Firebase/Plugins/x86_64/FirebaseCppApp-*.bundle.meta
