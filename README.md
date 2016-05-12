# Assistant
For the time being assistant is only a translator assist in my daily reading course.
It exercise google translate as it core side to traslate selected text, ask for better translation and if it's not already in the "phrase book" prompt for append in database.

## Installation
1. Rename "AccountInfo_sample.sh" to "AccountInfo.sh" and replace your cookie value in it. For more info on how to get your google cookie value visit [Mozilla Network Monitor](https://developer.mozilla.org/en-US/docs/Tools/Network_Monitor) page.
2. Compile Qt project
3. Add Assistant to your start up list ( I guarantee that it will be a quiet boy :) )
4. Create a shortcut for Script/Translate.sh. 

	if you like to map it to your mouse button first create xbind configuration file by
	`xbindkeys --defaults > ~/.xbindkeysrc`
	then coustomize following lines and add it to your configuration file
	
	```
	"/home/lolo/PathToAssistant/Scripts/Translate.sh"
	  b:8
	"/home/lolo/PathToAssistant/Scripts/DirectTranslate.sh"
	  Control + b:8
	```
	
	To inform xbind your changes run
	
	`killall xbindkeys;xbindkeys`
	
5. Add GSetting schema
	```
	sudo cp Resources/org.binaee.assistant.gschema.xml /usr/share/glib-2.0/schemas/;sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
	```
6. Enjoy


## Acknowledgments
Assistant used following library and tools, I just want to mention that this conquer can't achieved without their affords.
- Google Translate API
- sed
- wget
- awk
- qt
- xrandr
- D-Bus
- GSetting
- [webupd8](http://www.webupd8.org/2016/03/translate-any-text-you-select-on-your.html)
