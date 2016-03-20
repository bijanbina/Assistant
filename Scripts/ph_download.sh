#!/bin/sh
lastDir="$( pwd )"
baseDir="$(dirname "$0")"
cd $baseDir
source ../AccountInfo.sh 	#load account info
wget  -q --show-progress -U 'Mozilla/5.0'  --header="Cookie: $cookie" -O "phrasebookv0" $url #get phrasebook from google
sed "s/],\[/\n/g" phrasebookv0 > phrasebookv1
sed -i'' -e "s:\[.*\[::g" -e "s:].*]::g" phrasebookv1 #remove header & footer
sed -i'' "s:\"::g" phrasebookv1 #remove quotations
awk -F "," '{print $4,",",$5}' phrasebookv1 > phrasebookv2 #strip down to word and meaning
mv phrasebookv2 phrasebook	#for debug purpuse
rm phrasebookv0 phrasebookv1	#comment these lines
cd $lastDir
