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
echo $gxf
echo "Email=$1"  "Passwd=$2"
curl -c cooky_login 'https://accounts.google.com/signin/challenge/sl/password'  -H 'User-Agent: Mozilla/5.0' -H "Cookie: GAPS=$GAPS" --data 'Page=PasswordSeparationSignIn' --data-urlencode "gxf=$gxf" --data-urlencode "Email=$1" --data-urlencode "Passwd=$2">page.html
SID=`cat cooky_login |  grep -P '\tSID' | awk '{ print $7 }'`
HSID=`cat cooky_login | grep HSID | awk '{ print $7 }'`
SSID=`cat cooky_login | grep SSID | awk '{ print $7 }'`


COOKIE_TEXT="cookie=\"SID=$SID; HSID=$HSID; SSID=$SSID;\""
echo $COOKIE_TEXT > ../AccountInfo.sh
#rm cooky_login
