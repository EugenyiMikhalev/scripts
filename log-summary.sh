#!/bin/bash 
# Read logs from file line by line, count log entries by types from 2nd column, display all counts of entries.

if [ $# -ne 1 ]; then
  echo "Number of argumnets need to be 1" >&2
  exit 2
fi
if [ ! -f "$1" ]; then
  echo "$1 does not exist" >&2
  exit 1
fi
if [ ! -r "$1" ]; then
  echo "Cant read file $1" >&2
  exit 3
fi
INFO=0
WARN=0
ERROR=0
TOTAL=0
while IFS= read -r line; do
 
  read -r -a fields <<<"$line"
  if [[ ${fields[0]} == \#* ]]; then
    continue
  fi
  type="${fields[1]}"
  case $type in
	  ERROR) 
		  ((ERROR += 1))  
  		  ((TOTAL += 1))  
  		;;
	  INFO) 
		((INFO += 1)) 
		((TOTAL += 1))
	        ;;	
	  WARN) 
		((WARN += 1))
  		((TOTAL += 1))
		;;	
  esac
done < "$1"
echo "INFO=$INFO"
echo "WARN=$WARN"
echo "ERROR=$ERROR"
echo "TOTAL=$TOTAL"
exit 0;
