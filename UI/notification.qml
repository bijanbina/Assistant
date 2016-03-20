import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Window {
    flags: Qt.FramelessWindowHint
    width: 500
    height: 54
    x:x_base + (Screen.width - width) / 2
    y:y_base + 32
    color: "transparent"
    Rectangle{
        anchors.fill: parent
        radius:7
        color: "#2e3436"
        border.color: "#1c1f1f"
        border.width: 1
        MouseArea{
            onClicked: {Qt.quit(); console.log(Screen.height)}
            anchors.fill: parent
        }
    }

    property int x_base: 0 //this value get updated on start (in c sources)
    property int y_base: 0 //this value get updated on start (in c sources)
    visible: false
}

