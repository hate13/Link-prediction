#!/bin/bash

ENCODED=""
rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  # echo "${encoded}"    # You can either set a return variable (FASTER) 
  ENCODED="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

if [ "$1" = "-f" ]; then
    rawurlencode "`cat $2`"
    syntax=$3
else
    rawurlencode "$1"
    syntax=$2
fi

if [ -z "$syntax" ]; then syntax=text; fi

# echo $ENCODED, $syntax

curl -i -X POST -H "Content-type:text/html;charset=utf-8" -d "poster=hate13&syntax=$syntax&content=$ENCODED" http://paste.ubuntu.com
