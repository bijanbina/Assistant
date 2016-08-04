assistant_pid=$( ps -A | grep -i assistant )

if [ -n "$assistant_pid" ]; then
	echo "good"
	dbus-send --session --dest=com.binaee.assistant  / com.binaee.assistant.direct
else
	/home/bijan/Project/Assistant/Sources/Assistant --direct&
fi
