#/bin/sh

#
# Get GLAX
#
gxf=`curl -c cooky_login 'https://accounts.google.com/ServiceLogin' -H 'User-Agent: Mozilla/5.0' | grep gxf | sed "s/ /\n/g" | grep value | sed 's/[">]//g' | awk -F "=" '{printf $2}'`
GAPS=`cat cooky_login | grep GAPS | awk '{ print $7 }'`
# Example:
# after 1grep :   <input type="hidden" name="GALX" value="iOcAO2QwRpg"> 
# after 1sed  :   (print each word in new line)
# after 2grep :   value="iOcAO2QwRpg"> 
# after 2sed  :   (remove some chars) --> value=iOcAO2QwRpg
# after 1awk  :   iOcAO2QwRpg
#echo $gxf
#echo "Email=$1"  "Passwd=$2"
curl -c cooks 'https://accounts.google.com/signin/challenge/sl/password'  -H 'User-Agent: Mozilla/5.0' -H "Cookie: GAPS=$GAPS" --data 'Page=PasswordSeparationSignIn' --data-urlencode "gxf=$gxf" --data-urlencode "Email=$1" --data-urlencode "Passwd=$2">text
curl -b cooks -H 'User-Agent: Mozilla/5.0' "https://translate.google.com" > translatePage
sed -i'' "s/;/\n/g" translatePage #-i: edit in-place files
url=$( grep USAGE translatePage |  awk -F "'" '{printf $2}' )
curl -b cooks -H 'User-Agent: Mozilla/5.0' "https://translate.google.com/translate_a/sg?client=t&cm=g&hl=en&xt=$url" > phrasebookv0 #get phrasebook from google
sed "s/;/\n/g" phrasebookv0 > phrasebookv1
sed "s/],\[/\n/g" phrasebookv0 > phrasebookv1
sed -i'' -e "s:\[.*\[::g" -e "s:].*]::g" phrasebookv1 #remove header & footer
sed -i'' "s:\"::g" phrasebookv1 		#remove quotations
awk -F "," '{print $4,",",$5}' phrasebookv1 > phrasebookv2 #strip down to word and meaning
