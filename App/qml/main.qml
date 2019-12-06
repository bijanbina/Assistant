import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.0
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.1
import Qt.labs.settings 1.0
import QtMultimedia 5.5

Window {
    id: root
    objectName: "window"
    visible: true
    width: 400
    height: 570
    x: 2600
    y: 600

    color: "#161616"
    title: "Assistant"

    function toPixels(percentage)
    {
        return percentage * Math.min(root.width, root.height);
    }

    property bool isScreenPortrait: height > width
    property bool star_mode: false
    property bool isHighlight: false
    property color lightFontColor: "#222"
    property color darkFontColor: "#e7e7e7"
    readonly property color lightBackgroundColor: "#cccccc"
    readonly property color darkBackgroundColor: "#161616"
    property real customizerPropertySpacing: 10
    property real colorPickerRowSpacing: 8
    property string word1 : "word1"
    property string word2 : "word2"
    property string highlight_string : ""
    property int index_val : 1
    property int index_m : 1
    property int fa_search_c : 0 //last farsi search count (length)
    property int en_search_c : 0 //last farsi search count (length)


    Text
    {
        id: textSingleton
    }

    FontLoader
    {
        id: openSans
        source: "qrc:/fonts/OpenSans-Regular.ttf"
    }

    FontLoader
    {
        id: fontAwesome
        source: "qrc:/fonts/fasolid.ttf"
    }

    Audio
    {
        id: playMusic
        //source: "file:///home/bijan/Project/Assistant/Scripts/MP3/test.mp3"
        onStopped: {
            if (en_text.text.length > 2 || (fa_text.text.length > 2))
            {
                list_search.get(index_m-1).sColor = "#bbb"
            }
            else
            {
                list_el.get(index_m-1).sColor = "#bbb"
            }

        }
    }

    Rectangle
    {
        id: topBar
        height: 0.1 * root.height
        width: root.width
        anchors.left: root.left
        anchors.top: root.top
        color: "#222"
        z:2
        Rectangle
        {
            id: en_search

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: root.width/2.5
            anchors.leftMargin: textSingleton.implicitHeight

            color: "#222"

            TextInput
            {
                z:3
                id: en_text
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                width: parent.width
                font.pixelSize: root.height/30
                color: "#ccc"
                onTextChanged: {
                    if (en_text.text.length > 2)
                    {
                        if (en_search_c < en_text.text.length)
                        {
                            en_search_show(en_text.text, true);
                        }
                        else
                        {
                            en_search_show(en_text.text, false);
                        }

                        en_search_c = en_text.text.length
                        search_view.visible = true
                        lsview.visible = false
                        backBtn_lbl.text = '<'
                    }
                    else
                    {
                        forwrdBtn_lbl.text = '+'
                        backBtn_lbl.text = '-'
                        en_search_c = 0;
                        search_view.visible = false
                        lsview.visible = true
                    }
                }

                Text {
                    text: "En"
                    font.pixelSize: root.height/30
                    font.italic: true
                    color: "#ccc"
                    visible: !en_text.text && !en_text.activeFocus
                }
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.IBeamCursor
                    acceptedButtons: Qt.NoButton
                }
            }
        }
        Rectangle
        {
            id: star_btn
            anchors.left:  en_search.right
            anchors.right: fa_search.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            color: "#222"
            Label
            {
                id: star_lbl
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                text: "\uf005"
                color: "#ccc"
                font.pixelSize: root.height/30
                font.family: fontAwesome.name
                font.weight: Font.Black
                verticalAlignment: Text.AlignVCenter

            }
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    var index_value = lsview.indexAt(10,lsview.contentY)+1
                    var new_index = 0
                    if (star_mode)
                    {
                        star_lbl.color = "#ccc"

                        word1 = list_el.get(index_value-1).word
                        new_index = restoreList();
                    }
                    else
                    {
                        //4000 is max list index
                        while (index_value < 4000)
                        {
                            index_value = index_value + 1;
                            if (highlight_string[index_value-1] == 't')
                            {
                                break;
                            }
                        }

                        word1 = list_el.get(index_value-1).word
                        new_index = removeList();
                        star_lbl.color = "#ba862a"
                    }
                    updatePage()
                    lsview.forceLayout();
                    lsview.positionViewAtIndex(new_index - 1, ListView.Beginning)
                    star_mode = !star_mode;
                }
            }
        }
        Rectangle
        {
            id: fa_search
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            width: root.width/2.5
            anchors.rightMargin: textSingleton.implicitHeight
            color: "#222"

            TextInput
            {
                z:3
                id: fa_text
                width: parent.width
                anchors.left: parent.left
                font.pixelSize: root.height/40
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: TextInput.AlignRight
                color: "#ccc"
                onTextChanged: {
                    if (fa_text.text.length > 2)
                    {
                        if (fa_search_c < fa_text.text.length)
                        {
                            fa_search_show(fa_text.text, true);
                        }
                        else
                        {
                            fa_search_show(fa_text.text, false);
                        }

                        fa_search_c = fa_text.text.length
                        search_view.visible = true
                        lsview.visible = false
                        forwrdBtn_lbl.text = ''
                        backBtn_lbl.text = '<'
                    }
                    else
                    {
                        forwrdBtn_lbl.text = '+'
                        backBtn_lbl.text = '-'
                        fa_search_c = 0
                        search_view.visible = false
                        lsview.visible = true
                    }
                }

                Text {
                    text: "فارسی"
                    color: "#ccc"
                    anchors.right: parent.right
                    font.pixelSize: root.height/40
                    visible: !fa_text.text && !fa_text.activeFocus
                    horizontalAlignment: TextInput.AlignRight
                }
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.IBeamCursor
                    acceptedButtons: Qt.NoButton
                }
            }
        }
    }

    ListModel
    {
        id: list_backup
    }

    Rectangle
    {
        id: main_view
        height: 0.8 * parent.height
        width: parent.width
        anchors.left: parent.left
        anchors.top: topBar.bottom
        color: "#333"
        ListView
        {
            id: lsview
            anchors.fill: parent
            headerPositioning: ListView.PullBackHeader
            model: ListModel
            {
                id: list_el
            }

            delegate: BlackButtonBackground
            {
                width: root.width
                height: root.height * 0.125
                word_left: word
                word_right: translate
                word_index: index_i

                fontColor: root.darkFontColor
                isHighlighted: highlight
                soundColor: sColor
                onMouseOnSound:
                {
                    //change sColor only for clicked cell
                    sColor = "#2aba89"
                    sayWord(index_i) //this cannot replace with word. because after "sayWord"
                    // complete playing the prononciation if we don't have index we can't replace
                    // sound icon color back.
                }

                onClickedMe: {
                        // Only push the control view if we haven't already pushed it...
                        //addList()
                        changecl(index_i);
                        //forceView(3000)
                }

             }
             Keys.onPressed: {
                if (event.key == Qt.Key_Up) {
                    //console.log("move up");
                    lsview.contentY = lsview.contentY - 100
                    event.accepted = true;
                }
                if (event.key == Qt.Key_Down) {
                    //console.log("move up");
                    if (lsview.contentY + 100 > (lsview.contentHeight-root.height))
                        lsview.contentY = lsview.contentHeight - root.height;
                    else
                       lsview.contentY = lsview.contentY + 100
                    event.accepted = true;
                }
             }
             //focus: true

             onContentYChanged: updatePage()
             //onContentHeightChanged: {lsview.contentY = (settings.ls_cony)*100.0}
             onWidthChanged: {
                 //lsview.contentY = (settings.ls_cony)*100.0;
                 //updatePage(Math.round((settings.ls_cony)*100.0/(root.height * 0.125)));
             }
        }

        ListView
        {
            id: search_view
            anchors.fill: parent
            headerPositioning: ListView.PullBackHeader
            z: 2
            visible: false
            model: ListModel
            {
                id: list_search
            }

            delegate: BlackButtonBackground
            {
                width: root.width
                height: root.height * 0.125
                word_left: word
                word_right: translate
                word_index: index_m

                fontColor: root.darkFontColor
                isHighlighted: 0
                soundColor: sColor
                onMouseOnSound:
                {
                    //change sColor only for clicked cell
                    sColor = "#2aba89"
                    sayWord_search(index_i) //this cannot replace with word. because after "sayWord"
                    // complete playing the prononciation if we don't have index we can't replace
                    // sound icon color back.
                }
             }
        }
    }

    Rectangle
    {
        id: bottom_bar
        height: (parent.height - main_view.height)/2
        width: parent.width
        anchors.left: parent.left
        anchors.top: main_view.bottom
        color: "#222"
        Label
        {
            id: status
            width: root.width/2
            anchors.verticalCenter: parent.verticalCenter
            text : "hi"//settings.ls_cony
            font.pixelSize: root.height/40
            color: "#ccc"
        }
        Rectangle
        {
            id: backBtn
            anchors.right: forwrdBtn.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            width: root.width/5
            color: "#252525"
            Label
            {
                id: backBtn_lbl
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text : "-"
                color: "#ccc"
                font.pixelSize: root.height/15
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    if (en_text.text.length > 2 || fa_text.text.length > 2)
                    {
                        en_text.text = ''
                        fa_text.text = ''
                        lsview.forceActiveFocus()
                    }
                    else
                    {
                        if ( lsview.indexAt(10,lsview.contentY)+1 < 25 )
                        {
                            lsview.contentY = 1;
                        }
                        else
                        {
                            lsview.contentY = lsview.contentY - 25*(root.height * 0.125);
                        }
                    }
                }
            }
        }
        Rectangle
        {
            id: forwrdBtn
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            width: root.width/5
            color: "#252525"
            Label
            {
                id: forwrdBtn_lbl
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text : "+"
                color: "#ccc"
                font.pixelSize: root.height/20
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    if (lsview.indexAt(10,lsview.contentY)+25 > lsview.count)
                        lsview.positionViewAtEnd()
                    else
                       lsview.contentY = lsview.contentY + 25 * (root.height * 0.125)
                }
            }
        }
    }

    function addList() {
        if ( !isHighlight )
        {
            list_el.append({"index_i" : index_val , "word" : word1,
                            "translate" : word2, "highlight" : 0,
                            "sColor" : "#bbb"});
        }
        else
        {
            list_el.append({"index_i" : index_val , "word" : word1,
                           "translate" : word2, "highlight" : 1,
                           "sColor" : "#bbb"});
        }
        list_backup.append({"index_i" : index_val , "word" : word1, "translate" : word2});
    }

    function en_search_show(text, isClear)
    {
        var i = 0;
        var rc = 0;
        var max_size = list_search.count;
        //remove all previous search
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (list_search.get(i-rc).word.indexOf(text) == -1 || isClear )
            {
                list_search.remove(i-rc);
                rc = rc + 1;
            }
            else
            {
                list_search.get(i-rc).index_i = i-rc+1
            }
        }

        if (isClear)
        {
            max_size = list_backup.count;
            rc = 0;
            for ( i = 0 ; i < max_size ; i=i+1 )
            {
                if (list_backup.get(i).word.indexOf(text) !== -1 )
                {
                    rc = rc +1;
                    list_search.append({"index_i" : rc , "word" : list_backup.get(i).word,
                                        "translate" : list_backup.get(i).translate, "highlight" : 0,
                                        "sColor" : "#bbb", "index_m" : i});
                }
            }
        }
    }

    function fa_search_show(text, isClear)
    {
        var i = 0;
        var rc = 0;
        var max_size = list_search.count;
        //remove all previous search
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (list_search.get(i-rc).translate.indexOf(text) == -1 || isClear )
            {
                list_search.remove(i-rc);
                rc = rc + 1;
            }
            else
            {
                list_search.get(i-rc).index_i = i-rc+1
            }
        }
        if (isClear)
        {
            rc = 0
            max_size = list_backup.count;
            for ( i = 0 ; i < max_size ; i=i+1 )
            {
                if (list_backup.get(i).translate.indexOf(text) !== -1 )
                {
                    rc = rc +1;
                    list_search.append({"index_i" : rc , "word" : list_backup.get(i).word,
                                           "translate" : list_backup.get(i).translate, "highlight" : 0,
                                           "sColor" : "#bbb", "index_m" : i});
                }
            }
        }
    }

    function removeList() {
        var return_val = 0;
        var i = 0;
        var max_size = list_el.count;
        var rc = 0; //removed element counter
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (highlight_string[i] == 'f' )
            {
                list_el.remove(i-rc);
                rc = rc + 1;
            }
            else if ( word1 == list_el.get(i-rc).word )
            {
                return_val = i-rc;
                list_el.get(i-rc).index_i =  i-rc+1;
            }
            else
            {
                list_el.get(i-rc).index_i =  i-rc+1;
            }

        }
        return return_val;
    }

    function restoreList() {
        var return_val = 0;
        var i = 0;
        var max_size = list_backup.count;
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (highlight_string[i] == 'f' )
            {
                //index used for sayword
                list_el.insert(i, {"index_i" : i+1 , "word" : list_backup.get(i).word,
                                       "translate" : list_backup.get(i).translate, "highlight" : 0,
                                       "sColor" : "#bbb"})
            }
            else if ( word1 == list_backup.get(i).word )
            {
                return_val = i;
                list_el.get(i).index_i =  i+1;
            }
            else
            {
                list_el.get(i).index_i =  i+1;
            }

        }
        return return_val;
    }

    //Chnage color of index
    function changecl(ind)
    {
        if (!star_mode) //no change color in starmode
        {
            //toggle color on ui
            if ( list_el.get(ind-1).highlight == 1)
            {
                list_el.get(ind-1).highlight = 0
            }
            else
            {
                list_el.get(ind-1).highlight = 1
            }

            //change setting (f char=false, t char = true)
            if (highlight_string[ind-1] == 'f' )
            {
                highlight_string = highlight_string.substr(0, ind-1) + 't' + highlight_string.substr(ind);
                var last_ind = ind-2
                for ( ; last_ind > 0 ; last_ind-- )
                {
                    if (highlight_string[last_ind] != 'f' )
                    {
                        break;
                    }
                }

                if ( last_ind == 0 )
                {
                    add_highlight(list_el.get(ind-1).word, "")
                }
                else
                {
                    add_highlight(list_el.get(ind-1).word, list_el.get(last_ind).word)
                }
            }
            else
            {
                highlight_string = highlight_string.substr(0, ind-1) + 'f' + highlight_string.substr(ind);
                remove_highlight(list_el.get(ind-1).word)
            }
        }
        else //in star_mode
        {
            if ( list_el.get(ind-1).highlight == 2)
            {
                list_el.get(ind-1).highlight = 1
            }
            else
            {
                list_el.get(ind-1).highlight = 2
            }
        }
    }

    function sayWord(ind)
    {
        //list_el.get(ind-1).sColor = "#2aba89"
        //playMusic.source = "file:///home/bijan/Project/Assistant/Scripts/MP3/" + list_el.get(ind-1).word + ".mp3"
        playMusic.source = "file:///storage/emulated/0/BIC/MP3/" + list_el.get(ind-1).word + ".mp3"
        playMusic.play()
        index_m = ind;
    }

    function sayWord_search(ind)
    {
        //list_el.get(ind-1).sColor = "#2aba89"
        //playMusic.source = "file:///home/bijan/Project/Assistant/Scripts/MP3/" + list_search.get(ind-1).word + ".mp3"
        playMusic.source = "file:///storage/emulated/0/BIC/MP3/" + list_search.get(ind-1).word + ".mp3"
        playMusic.play()
        index_m = ind;
    }

    function forceView(ind)
    {
        //lsview.positionViewAtIndex(ind, ListView.Center)
        lsview.positionViewAtIndex(ind - 1, ListView.Beginning)
    }

    Settings
    {
        id: settings
        property double ls_cony: 0//Math.round(lsview.contentY/100)
        property string card_highlight
    }

    Component.onDestruction: {
        if (!star_mode)
        {
            settings.ls_cony = lsview.indexAt(10,lsview.contentY) + 1
        }
    }


    function itemAdded()
    {
        forceView(settings.ls_cony) // work for htc one
        //lsview.contentY = (5000)*100.0
        //updatePage(Math.round(lsview.contentY/(root.height * 0.125)))
        updatePage()
        /*if (highlight_string.length<6000)
        {
            var t = new String
            for (var i = 0; i < 6000; i++)
            {
                t = t.concat('f')
            }
            highlight_string = t;
            console.log (highlight_string.length)
        }*/
    }

    function updatePage()
    {
        status.text = lsview.indexAt(10,lsview.contentY)+1 + " / " +
                list_el.count +
                "\nV0.12 - Settings: " + settings.ls_cony;
    }

    signal remove_highlight(string word)
    signal add_highlight(string word, string last)
}


