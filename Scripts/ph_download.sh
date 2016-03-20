#!/bin/sh

source ../AccountInfo.sh 	#Load Account Info
wget  -q --show-progress -U 'Mozilla/5.0'  --header="Cookie: $cookie" -O "phrasebook" $url #Get PhraseBook from google


