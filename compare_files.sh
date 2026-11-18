#! /bin/bash
if [ $# -ne 2 ]; then
	echo "Please, provide 2 files to compare"
	exit 4
fi
if [ ! -f "$1" ]; then
	echo "$1 is not a file"
	exit 2
fi
if [ ! -f "$2" ]; then
	echo "$2 is not a file"
	exit 3
fi
LINES1=$(wc -l "$1" | awk '{print $1}')
LINES2=$(wc -l "$2" | awk '{print $1}')
if [ "$LINES1" -ne "$LINES2" ]; then
	echo "Files are NOT equal. "$1" has "$LINES1" lines while "$2" has "$LINES2" lines"
	exit 0
fi
WORDS1=$(wc "$1" | awk '{print $2}')
WORDS2=$(wc "$2" | awk '{print $2}')
if [ "$WORDS1" -ne "$WORDS2" ]; then
	echo "Files are NOT equal. "$1" has "$WORDS1" words while "$2" has "$WORDS2" words"
	exit 0
fi
diff "$1" "$2" > /dev/null 2>&1 && {
echo "Files are equal"
exit 0
} || {
echo "Files are NOT equal" >&2
exit 1
}
