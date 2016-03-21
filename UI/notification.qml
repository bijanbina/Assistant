import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Window {
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.SplashScreen
    id: notif
    width: 500
    height: 60
    x:x_base + (Screen.width - width) / 2
    y:y_base + 32
    color: "transparent"
    Rectangle{
        anchors.fill: parent
        radius:6
        color: "#2e3436"
        border.color: "#1c1f1f"
        border.width: 1
        MouseArea{
            anchors.fill: parent
        }
        Image
         {
             anchors.left: parent.left
             anchors.verticalCenter: parent.verticalCenter
             anchors.leftMargin: notif.width * 0.03
             source: "qrc:GIcon48.png"
             id:icon
             height : 35
             width: 35
             property bool isStarted: false
             MouseArea
             {
                 id:menubtn_mousearea
                 anchors.fill: parent
             }
         }

        Label
        {
            id:titleLbl
            text : title
            color: "#fff";
            font.weight: Font.Bold
            font.family: "Sans"
            font.pixelSize: 13
            anchors.left: icon.right
            anchors.leftMargin: notif.width * 0.03
            anchors.topMargin: notif.height * 0.13
            anchors.top: parent.top

        }
        Label
        {
            id:contextLbl
            text : context
            color: "#fff";
            font.weight: Font.Normal
            font.family: "Sans"
            font.pixelSize: 13
            anchors.left: icon.right
            anchors.leftMargin: notif.width * 0.03
            anchors.topMargin: notif.height * 0.1
            anchors.top: titleLbl.bottom

        }

        Image
         {
             anchors.right: parent.right
             anchors.top: parent.top
             anchors.rightMargin: notif.width * 0.02
             anchors.topMargin: notif.width * 0.02
             source: "qrc:window-close.png"
             id:closeBtn
             height : 14
             width: 14
             property bool isStarted: false
             MouseArea
             {
                 onClicked: {Qt.quit()}
                 anchors.fill: parent
             }
         }
    }


    Timer {
        id:timeoutTimr
        interval: 7000; running: false; repeat: false
        onTriggered: notif.visible=false
    }

    function startNotif() {
        timeoutTimr.start();
    }

    property int x_base: 0 //this value get updated on start (in c sources)
    property int y_base: 0 //this value get updated on start (in c sources)
    property string context: 'text' //this value get updated on start (in c sources)
    property string title: 'title' //this value get updated on start (in c sources)
    visible: false
}

