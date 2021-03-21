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
import "qrc:/"

Window
{
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
    property int pc_mode : 1
    property bool focus_list: true //focus on list when another element not focused.

    signal remove_highlight(string word)
    signal add_highlight(string word, string last)

    id: root
    objectName: "window"
    visible: true
    width:
    {
        if (pc_mode)
        {
            1400
        }
        else
        {
            400
        }
    }
    height:
    {
        if (pc_mode)
        {
            600
        }
            else
        {
            570
        }
    }
    x: 200
    y: 100

    color: "#161616"
    title: "Assistant"

    Component.onDestruction:
    {
        if (!star_mode)
        {
            if(pc_mode)
            {
                settings.ls_cony = main_view_pc.getLsConY()
            }
            else
            {
                settings.ls_cony = main_view_mobile.getLsConY()
            }

        }
    }

    Settings
    {
        id: settings
        property double ls_cony: 0
        property string card_highlight
    }

    FontLoader
    {
        id: openSans
        source: "qrc:/OpenSans-Regular.ttf"
    }

    FontLoader
    {
        id: fontAwesome
        source: "qrc:/fasolid.ttf"
    }

    Text
    {
        id: textSingleton
    }

    Audio
    {
        id: playMusic
        onStopped:
        {
            if(pc_mode)
            {
                main_view_pc.pronStopped(index_m)
            }
            else
            {
                main_view_mobile.pronStopped(index_m)
            }
        }

        onError:
        {
            if(pc_mode)
            {
                main_view_pc.pronError(index_m)
            }
            else
            {
                main_view_mobile.pronError(index_m)
            }
        }
    }

    Rectangle
    {
        id: topBar
        height: 0.1 * root.height
        width: root.width
        anchors.left: parent.left
        anchors.top: parent.top
        color: "#222"
        z: 2
//        visible: false

        SearchBar
        {
            id: en_search
            height: parent.height
            anchors.right: star_btn.left
            anchors.left: parent.left
            anchors.top: parent.top
            text_search: "En"
            onSearchWord:
            {
                if (word.length > 2)
                {
                    var clear = en_search_c < word.length

                    if(pc_mode)
                    {
                        main_view_pc.en_search_show(word, clear)
                        main_view_pc.showSearchView()
                    }
                    else
                    {
                        main_view_mobile.en_search_show(word, clear)
                        main_view_mobile.showSearchView()
                    }
                    en_search_c = word.length
                }
                else
                {
                    en_search_c = 0
                    if(pc_mode)
                    {
                        main_view_pc.hideSearchView()
                    }
                    else
                    {
                        main_view_mobile.hideSearchView()
                    }
                }
            }
        }

        FavoriteButton
        {
            id: star_btn
            width: 50
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onClickedBtn:
            {
                if(pc_mode)
                {
                    main_view_pc.changeStarMode()
                }
                else
                {
                    main_view_mobile.changeStarMode()
                }
            }
        }

        SearchBar
        {
            id: fa_search
            height: parent.height
            anchors.right: parent.right
            anchors.left: star_btn.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            text_search: "فارسی"
            fa_mode: true
            onSearchWord:
            {
                if (word.length > 2)
                {
                    var clear = en_search_c < word.length
                    if(pc_mode)
                    {
//                        main_view_pc.fa_search_show(word, clear)
//                        main_view_pc.showSearchView()
                    }
                    else
                    {
                        main_view_mobile.fa_search_show(word, clear)
                        main_view_mobile.showSearchView()
                    }
                    fa_search_c = word.length
                }
                else
                {
                    en_search_c = 0
                    if(pc_mode)
                    {
                        main_view_pc.hideSearchView()
                    }
                    else
                    {
                        main_view_mobile.hideSearchView()
                    }
                }
            }
        }

//        Rectangle
//        {
//            id: en_search

//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.left: parent.left
//            width: root.width/2.5
//            anchors.leftMargin: textSingleton.implicitHeight
//            color: "#222"

//            TextInput
//            {
//                z:3
//                id: en_text
//                anchors.left: parent.left
//                anchors.verticalCenter: parent.verticalCenter

//                width: parent.width
//                font.pixelSize: root.height/30
//                color: "#ccc"
//                onTextChanged:
//                {
//                    if (en_text.text.length > 2)
//                    {
//                        if (en_search_c < en_text.text.length)
//                        {
//                            main_view.en_search_show(en_text.text, true);
//                        }
//                        else
//                        {
//                            main_view.en_search_show(en_text.text, false);
//                        }
//                        en_search_c = en_text.text.length
//                        main_view.showSearchView()
//                        backBtn_lbl.text = '<'
//                    }
//                    else
//                    {
//                        forwrdBtn_lbl.text = '+'
//                        backBtn_lbl.text = '-'
//                        en_search_c = 0;
//                        main_view.hideSearchView()
//                    }
//                }

//                Text
//                {
//                    text: "En"
//                    font.pixelSize: root.height/30
//                    font.italic: true
//                    color: "#ccc"
//                    visible: !en_text.text && !en_text.activeFocus
//                }

//                MouseArea
//                {
//                    anchors.fill: parent
//                    cursorShape: Qt.IBeamCursor
//                    acceptedButtons: Qt.NoButton
//                }
//            }
//        }

//        Rectangle
//        {
//            id: star_btn
//            anchors.left:  en_search.right
//            anchors.right: fa_search.left
//            anchors.bottom: parent.bottom
//            anchors.top: parent.top
//            color: "#222"

//            Label
//            {
//                id: star_lbl
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter

//                text: "\uf005"
//                color: "#ccc"
//                font.pixelSize: root.height/30
//                font.family: fontAwesome.name
//                font.weight: Font.Black
//                verticalAlignment: Text.AlignVCenter

//            }

//            MouseArea
//            {
//                anchors.fill: parent
//                onClicked:
//                {
//                    var index_value = lsview.indexAt(10,lsview.contentY)+1
//                    var new_index = 0
//                    if (star_mode)
//                    {
//                        star_lbl.color = "#ccc"

//                        word1 = list_el.get(index_value-1).word
//                        new_index = restoreList();
//                    }
//                    else
//                    {
//                        //4000 is max list index
//                        while (index_value < 4000)
//                        {
//                            index_value = index_value + 1;
//                            if (highlight_string[index_value-1] == 't')
//                            {
//                                break;
//                            }
//                        }

//                        word1 = list_el.get(index_value-1).word
//                        new_index = removeList();
//                        star_lbl.color = "#ba862a"
//                    }
//                    updatePage()
//                    lsview.forceLayout();
//                    lsview.positionViewAtIndex(new_index - 1, ListView.Beginning)
//                    star_mode = !star_mode;
//                }
//            }
//        }

//        Rectangle
//        {
//            id: fa_search
//            anchors.right: parent.right
//            anchors.bottom: parent.bottom
//            anchors.top: parent.top
//            width: root.width/2.5
//            anchors.rightMargin: textSingleton.implicitHeight
//            color: "#222"

//            TextInput
//            {
//                z:3
//                id: fa_text
//                width: parent.width
//                anchors.left: parent.left
//                font.pixelSize: root.height/40
//                anchors.verticalCenter: parent.verticalCenter
//                horizontalAlignment: TextInput.AlignRight
//                color: "#ccc"
//                selectByMouse: true
//                onTextChanged:
//                {
//                    if (fa_text.text.length > 2)
//                    {
//                        if (fa_search_c < fa_text.text.length)
//                        {
//                            main_view.fa_search_show(fa_text.text, true);
//                        }
//                        else
//                        {
//                            main_view.fa_search_show(fa_text.text, false);
//                        }

//                        fa_search_c = fa_text.text.length
//                        main_view.showSearchView()
//                        forwrdBtn_lbl.text = ''
//                        backBtn_lbl.text = '<'
//                    }
//                    else
//                    {
//                        forwrdBtn_lbl.text = '+'
//                        backBtn_lbl.text = '-'
//                        fa_search_c = 0
//                        main_view.hideSearchView()
//                    }
//                }

//                Text
//                {
//                    text: "فارسی"
//                    color: "#ccc"
//                    anchors.right: parent.right
//                    font.pixelSize: root.height/40
//                    visible: !fa_text.text && !fa_text.activeFocus
//                    horizontalAlignment: TextInput.AlignRight
//                }

//                MouseArea
//                {
//                    anchors.fill: parent
//                    cursorShape: Qt.IBeamCursor
//                    acceptedButtons: Qt.NoButton
//                }
//            }
//        }


    }

    ListModel
    {
        id: list_backup
    }

    WordList
    {
        id: main_view_mobile
        width: root.width
        anchors.left: parent.left
        anchors.top: topBar.bottom
        anchors.bottom: bottom_bar.top
        color: "#333"
        visible: !pc_mode
    }

    WordList4
    {
        id: main_view_pc
        width: root.width
        anchors.left: parent.left
        anchors.top: topBar.bottom
        anchors.bottom: bottom_bar.top
        color: "#333"
        visible: pc_mode
    }

    Rectangle
    {
        id: bottom_bar
        height: 0.1 * root.height
        width: parent.width
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        color: topBar.color
        z: topBar.z
//        visible: false

        Label
        {
            id: status
            width: root.width/2
            anchors.verticalCenter: parent.verticalCenter
            text : "hi"//settings.ls_cony
            font.pixelSize: root.height/40
            color: "#ccc"
        }

        BottomButton
        {
            id: back_btn
            anchors.right: forward_btn.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: root.width/5
            text_label: "-"
            visible: !clear_btn.visible
            onClickedLabel:
            {
                if(pc_mode)
                {
                    main_view_pc.fastScrollUp(25)
                }
                else
                {
                    main_view_mobile.fastScrollUp(25)
                }
            }
        }

        BottomButton
        {
            id: clear_btn
            anchors.right: forward_btn.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: root.width/5
            text_label: "<"
            visible: (en_search.active_search || fa_search.active_search)
        }

        BottomButton
        {
            id: forward_btn
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: back_btn.width
            text_label: "+"
            onClickedLabel:
            {
                if(pc_mode)
                {
                    main_view_pc.fastScrollDown(25)
                }
                else
                {
                    main_view_mobile.fastScrollDown(25)
                }

            }
        }

    }

    function addList()
    {
        list_backup.append({"index_i" : index_val , "word" : word1, "translate" : word2})
        if(pc_mode)
        {
            main_view_pc.addList(isHighlight, index_val, word1, word2)
        }
        else
        {
            main_view_mobile.addList(isHighlight, index_val, word1, word2)
        }
    }

    function itemAdded()
    {
        if(pc_mode)
        {
            main_view_pc.forceView(settings.ls_cony) // work for htc one
        }
        else
        {
            main_view_mobile.forceView(settings.ls_cony) // work for htc one

        }
        updatePage()
    }

    function updatePage()
    {
        var lsConY
        var lsCount
        if(pc_mode)
        {
            lsConY = main_view_pc.getLsConY()+1
            lsCount = main_view_pc.getLsCount()
        }
        else
        {
            lsConY = main_view_mobile.getLsConY()+1
            lsCount = main_view_mobile.getLsCount()
        }

        status.text = lsConY + " / " + lsCount +
                "\nV0.12 - Settings: " + settings.ls_cony;
    }

}


