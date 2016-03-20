# Assistant
For the time being assistant is only a translator assist in my daily reading course.
It exercise google translate as it core side to scan traslate selected text, ask for better translation and if it's not already in the "phrase book" prompt for append in database.

## Installation
1. Create "AccountInfo_sample.sh" to "AccountInfo.sh".
2. get Cookie and phrasebook path by sniff http request. you can do that in firefox by ctrl+shift+q in Firefox
3. Replace AccountInfo data with your cookie and url value.


## Acknowledgments
Assistant used following library, I just want to mention that this conquer can't achieved without their affords.
- Google Translate API
- sed
- wget
- awk
- libnotify
- [webupd8](http://www.webupd8.org/2016/03/translate-any-text-you-select-on-your.html)
