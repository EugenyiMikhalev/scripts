#!/bin/bash
if [ "$#" -ne 1 ]; then
    printf 'Usage: %s DIRECTORY\n' "$0" >&2
    exit 2
fi
root="$1"
if [ ! -d "$root" ]; then
    printf 'Not a directory: %s\n' "$root" >&2
    exit 3
fi
count=0
bytes=0
while IFS= read -r -d '' file; do
    size=$(stat -c '%s' -- "$file") || exit 4
    count=$((count + 1))
    bytes=$((bytes + size))
done < <(find "$root" -type f -name '*.log' -print0)
printf 'FILES=%s\nBYTES=%s\n' "$count" "$bytes"
