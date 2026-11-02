#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 FILE" >&2
    exit 1
fi
if [ $# -gt 1 ]; then
    echo "Invalid number of arguments. Provide only one file" >&2
    exit 2
fi

file=$1
if [ -d "$file" ]; then
    echo "Provided argument is directory. Need a file" >&2
    exit 3
fi
if [ ! -f "$file" ]; then
    echo "Provided file doesnt exist" >&2
    exit 5
fi
if [ ! -r "$file" ]; then
    echo "No rights to read $file" >&2
    exit 4
fi
sum=$(sha256sum "$file" | cut -d ' ' -f1)
bytes=$(wc -c < "$file")
printf 'SHA256=%s\nBYTES=%s\n' "$sum" "$bytes"
exit 0
