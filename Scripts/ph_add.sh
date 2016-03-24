#!/bin/sh
lastDir="$( pwd )"
baseDir="$(dirname "$0")"
cd $baseDir
source ../AccountInfo.sh 	#load account info

if [ -n "$1" ]; then
	WORD=$1
else
	echo "ph_add <word> <translate>"
	exit 0
fi

if [ -n "$2" ]; then
	TRANSLATE=$2
else
	echo "ph_add <word> <translate>"
	exit 0
fi


wget  -qO- --show-progress -U 'Mozilla/5.0'  --header="Cookie: $cookie" --post-data="q=$WORD&utrans=$TRANSLATE" $url_add #get phrasebook from google
