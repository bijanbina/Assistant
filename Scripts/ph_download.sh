#!/bin/sh
lastDir="$( pwd )"
baseDir="$(dirname "$0")"
cd $baseDir
source ../AccountInfo.sh 	#load account info

#parse phrasebook url
wget  -q --show-progress -U 'Mozilla/5.0'  --header="Cookie: $cookie" -O "translatePage" "https://translate.google.com" #get phrasebook from google
sed -i'' "s/,/\n/g" translatePage #-i: edit in-place files
url=$( grep graphite_xsrf_token translatePage | head -1 | awk -F "'" '{printf $2}' )
gsettings set org.binaee.assistant url-code "$url"	#update url code
#ALkJrhgAAAAAW_HitvCN6e45PhwYoCpnNmOWc8bc64j_
#wget  -q --show-progress -U 'Mozilla/5.0'  --header="Cookie: $cookie" -O "phrasebookv0" "https://translate.google.com/translate_a/sg?client=t&cm=g&hl=en&xt=$url" #get phrasebook from google
wget  -q --show-progress -U 'Mozilla/5.0'  --header="Cookie: $cookie" -O "phrasebookv0" "https://translate.google.com/translate_a/sg?client=webapp&cm=g&hl=en&xt=$url" #get phrasebook from google
sed "s/;/\n/g" phrasebookv0 > phrasebookv1
sed "s/],\[/\n/g" phrasebookv0 > phrasebookv1
sed -i'' -e "s:\[.*\[::g" -e "s:].*]::g" phrasebookv1 #remove header & footer
sed -i'' "s:\"::g" phrasebookv1 		#remove quotations
awk -F "," '{print $4,",",$5}' phrasebookv1 > phrasebookv2 #strip down to word and meaning
mv phrasebookv2 phrasebook			#for debug purpuse
#rm translatePage phrasebookv0 phrasebookv1	#comment these lines constrains
cd $lastDir
