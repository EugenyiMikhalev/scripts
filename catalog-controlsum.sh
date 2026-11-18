#! /bin/bash
# Рекурсивно записывает в файл result.txt (если такой файл существует, создает result_1.txt и т.д.) контрольные суммы файлов из переданного каталога.
if [ -f "$2" ]; then
	RES_FILE="$2"
else
	DIR="$( cd "$( dirname "$0" )" && pwd )"
	if [ ! -f "$DIR/result.txt" ]; then
		RES_FILE="$DIR/result.txt"
	else
		I=1
		while [ -f "$DIR/result_$I.txt" ]; do
			I=$((I + 1))
		done
		RES_FILE="$DIR/result_$I.txt"
	fi
	echo "" > "$RES_FILE"
fi
entries=$(ls -l "$1" | awk '{print $9}') 
while IFS= read -r word; do
	[[ -z "$word" ]] && continue
	if [ -f "$1/$word" ]; then
		sha256sum "$1/$word" >> "$RES_FILE"
	else 
		if [ -d "$1/$word" ]; then
			bash "$0" "$1/$word" "$RES_FILE" >> "$RES_FILE" 2>> "errors.txt" 
		fi
	fi
done <<< "$entries"
exit 0
