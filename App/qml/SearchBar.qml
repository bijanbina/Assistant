import QtQuick 2.0

Rectangle
{
    property color color_background: "#222"
    property bool active_search: text_input_search.focus

    property color color_backgroun_text_input: "#ccc"
    property int left_margin_text_input: 5
    property int right_margin_text_input: 5

    property string text_search: "En"
    property color color_text_search: "#ccc"
    property real pixel_size_text_search: root.height/40

    property bool fa_mode: false

    signal searchWord(string word)

    color: "transparent"

    TextInput
    {
        id: text_input_search
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: left_margin_text_input
        anchors.rightMargin: right_margin_text_input
        color: color_backgroun_text_input
        selectByMouse: true
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: fa_mode ? TextInput.AlignRight:TextInput.AlignLeft
        font.pixelSize: pixel_size_text_search

        Keys.onEscapePressed: focus = false

        onFocusChanged:
        {
            root.focus_list = !focus
            if(!focus)
            {
                text = ""
            }
        }

        onTextChanged:
        {
            searchWord(text)
        }

        Text
        {
            id: id_text_search
            text: text_search
            color: color_text_search
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: pixel_size_text_search
            visible: (text_input_search.text.length===0 && !text_input_search.activeFocus)
            horizontalAlignment: fa_mode ? TextInput.AlignRight:TextInput.AlignLeft
        }

        MouseArea
        {
            anchors.fill: parent
            cursorShape: Qt.IBeamCursor
            acceptedButtons: Qt.NoButton
            onClicked:
            {
                console.log("clicked")
            }
        }

    }
}
