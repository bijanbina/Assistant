import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle
{
    id: container

    property bool hovered_btn: false

    property color color_background_hovered: "#252550"
    property color color_background_normal: "#252525"
    property color color_background:
    {
        if(hovered_btn)
        {
            color_background_hovered
        }
        else
        {
            color_background_normal
        }
    }

    property string text_label: "+"
    property color color_label: "#ccc"
    property real pixel_size_label: root.height/20

    signal clickedLabel()

    color: color_background

    Label
    {
        id: btn_lbl
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: text_label
        color: color_label
        font.pixelSize: pixel_size_label
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: root.pc_mode

        onClicked:
        {
            focus_list = false
            forceActiveFocus()
            clickedLabel()
            focus_list = true
        }

        onEntered:
        {
            hovered_btn = true
        }

        onExited:
        {
            hovered_btn = false
        }
    }

}
