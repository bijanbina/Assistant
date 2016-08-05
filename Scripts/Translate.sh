assistant_pid=$( ps -A | grep -i assistant )

if [ -n "$1" ]; then
	word=$1
else
	word=$( xsel -o | sed "s/[\"'<>]//g" )
fi

if [ -n "$assistant_pid" ]; then
	#this use calling directly the function not calling the signal
	#dbus-send --session --dest=com.binaee.assistant --type=method_call  / com.binaee.assistant.translate string:"$word"  
	dbus-send --session --dest=com.binaee.assistant / com.binaee.assistant.translate string:"$word"
else
	/home/bijan/Project/Assistant/Sources/Assistant --translate "$word" &
fi




