word=$( xsel -o | sed "s/[\"'<>]//g" )
dbus-send --session --dest=com.binaee.assistant --type=method_call  / com.binaee.assistant.translate string:"$word"
