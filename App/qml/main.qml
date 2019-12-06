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
                            main_view.en_search_show(en_text.text, true);
                        }
                        else
                        {
                            main_view.en_search_show(en_text.text, false);
                        }

                        en_search_c = en_text.text.length
                        main_view.showSearchView()
                        backBtn_lbl.text = '<'
                    }
                    else
                    {
                        forwrdBtn_lbl.text = '+'
                        backBtn_lbl.text = '-'
                        en_search_c = 0;
                        main_view.hideSearchView()
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
                            main_view.fa_search_show(fa_text.text, true);
                        }
                        else
                        {
                            main_view.fa_search_show(fa_text.text, false);
                        }

                        fa_search_c = fa_text.text.length
                        main_view.showSearchView()
                        forwrdBtn_lbl.text = ''
                        backBtn_lbl.text = '<'
                    }
                    else
                    {
                        forwrdBtn_lbl.text = '+'
                        backBtn_lbl.text = '-'
                        fa_search_c = 0
                        main_view.hideSearchView()
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

    WordList
    {
        id: main_view

        height: 0.8 * parent.height
        width: parent.width
        anchors.left: parent.left
        anchors.top: topBar.bottom
        color: "#333"
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

    function addList()
    {
        main_view.addList(isHighlight, index_val, word1, word2)
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
            settings.ls_cony = main_view.getLsConY()
        }
    }


    function itemAdded()
    {
        main_view.forceView(settings.ls_cony) // work for htc one
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

        status.text = main_view.getLsConY() + " / " +
                main_view.getLsCount() +
                "\nV0.12 - Settings: " + settings.ls_cony;
    }

    signal remove_highlight(string word)
    signal add_highlight(string word, string last)
}


