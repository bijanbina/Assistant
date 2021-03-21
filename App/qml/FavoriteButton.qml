import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle
{
    property color color_background: "#222"
    property bool enabled_btn: root.star_mode

    property color color_background_label_disable: "#ccc"
    property color color_background_label_enabled: "#ba862a"
    property color color_background_label:
    {
        if(enabled_btn)
        {
            color_background_label_enabled
        }
        else
        {
            color_background_label_disable
        }
    }
    property real pixel_size_label: root.height/30
    property string font_name_label: fontAwesome.name
    property int font_weight_label: Font.Black
    property string text_label: "\uf005"

    signal clickedBtn()

    color: color_background

    Label
    {
        id: label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: text_label
        color: color_background_label
        font.pixelSize: pixel_size_label
        font.family: font_name_label
        font.weight: font_weight_label
        verticalAlignment: Text.AlignVCenter

    }

    MouseArea
    {
        anchors.fill: parent

        onClicked:
        {
            root.star_mode = !root.star_mode
            clickedBtn()
        }

    }

}
