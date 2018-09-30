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
        echo $word
        wget  -q --show-progress -U 'Mozilla/5.0'  -O "ldPage" "https://www.ldoceonline.com/dictionary/$word" #get phrasebook from google
        url=$( grep 'class="speaker amefile fa fa-volume-up hideOnAmp"' ldPage -m 1 |  awk '{printf $2}' |  awk -F '=' '{printf $2}' |  awk -F '?' '{printf $1}' |  awk -F '"' '{printf $2}' )
        wget  -q --show-progress -U 'Mozilla/5.0'  -O "$word"".mp3" $url
    fi
done 

cd $lastDir
