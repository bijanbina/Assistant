#!/bin/sh
lastDir="$( pwd )"
baseDir="$(dirname "$0")"
cd $baseDir
source ../AccountInfo.sh 	#Load Account Info
wget  -q --show-progress -U 'Mozilla/5.0'  --header="Cookie: $cookie" -O "phrasebook" $url #Get PhraseBook from google


cd $lastDir
