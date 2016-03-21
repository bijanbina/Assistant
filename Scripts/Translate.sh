if [ -n "$1" ]; then
	word=$1
else
	word=$( xsel -o | sed "s/[\"'<>]//g" )
fi

dbus-send --session --dest=com.binaee.assistant --type=method_call  / com.binaee.assistant.translate string:"$word"
