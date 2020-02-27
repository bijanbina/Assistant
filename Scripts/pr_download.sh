#!/bin/sh
lastDir="$( pwd )"
baseDir="$(dirname "$0")"
cd $baseDir

MAX_LEN=$( wc -l phrasebook | awk '{printf $1}' )
echo $MAX_LEN

for NUM in `seq 1 $MAX_LEN`;
do
    word=$( sed "${NUM}q;d" phrasebook | awk -F ',' '{printf $1}' |  awk '{printf $1}' )
    FILE="MP3/$word.mp3"
    if [ ! -f $FILE ]; then
        echo "$NUM:$word"
        wget -q -U 'Mozilla/5.0' -O "ldPage" "https://www.ldoceonline.com/search/direct/?q=$word" #get phrasebook from google
        url=$( grep 'class="speaker amefile fa fa-volume-up hideOnAmp"' ldPage -m 1 |  awk '{printf $2}' |  awk -F '=' '{printf $2}' |  awk -F '?' '{printf $1}' |  awk -F '"' '{printf $2}' )
        #echo "$url"
        if [ -z "$url" ];then
            guess=$( grep '<a href="/search/direct/?q=' ldPage -m 1 | awk -F '=' '{printf $3}' |  awk -F '"' '{printf $1}' )
            #echo "guess = $guess"
            #exit
            wget -q -U 'Mozilla/5.0' -O "ldPage" "https://www.ldoceonline.com/dictionary/$guess" #get phrasebook from google
            url=$( grep 'class="speaker amefile fa fa-volume-up hideOnAmp"' ldPage -m 1 |  awk '{printf $2}' |  awk -F '=' '{printf $2}' |  awk -F '?' '{printf $1}' |  awk -F '"' '{printf $2}' )
        fi
        wget -q -U 'Mozilla/5.0' -O "MP3/$word.mp3" "$url"
        #exit
    fi
done 

cd $lastDir
