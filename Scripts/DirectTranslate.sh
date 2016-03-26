assistant_pid=$( ps -A | grep -i assistant )

if [ -n "$assistant_pid" ]; then
	echo "good"
else
	/home/bijan/Project/Assistant/Sources/Assistant &
	sleep 0.5
fi

dbus-send --session --dest=com.binaee.assistant  / com.binaee.assistant.direct
