import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Window {
    flags: Qt.FramelessWindowHint | Qt.SplashScreen // | Qt.WindowStaysOnTopHint;
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
            //anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: notif.width * 0.03
            source: "qrc:GIcon48.png"
            id:icon
            y:12
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
            font.family: "Cantarell"
            font.pixelSize: 13
            anchors.left: icon.right
            anchors.leftMargin: notif.width * 0.03
            anchors.topMargin: 11
            anchors.top: parent.top

        }
        Label
        {
            id:contextLbl
            text : context
            color: "#fff";
            font.weight: Font.Normal
            font.family: "Cantarell"
            font.pixelSize: 13
            anchors.right: parent.right
            anchors.rightMargin: notif.width * 0.09
            anchors.topMargin: 7.5
            anchors.top: titleLbl.bottom
        }

        Label
        {
            id:descriptionLbl
            text : description
            color: "#fff";
            font.weight: Font.Normal
            font.family: "Cantarell"
            font.pixelSize: 9
            anchors.right: contextLbl.left
            anchors.rightMargin: notif.width * 0.01
            anchors.topMargin: 11
            anchors.top: titleLbl.bottom
            visible: expand
        }

        Image
        {
            id:closeBtn
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: notif.width * 0.02
            anchors.topMargin: notif.width * 0.02
            source: "qrc:window-close.png"
            height : 14
            width: 14
            property bool isStarted: false
            MouseArea
            {
                onClicked: notif.hide() //Qt.quit()
                anchors.fill: parent
            }
        }

        Rectangle
        {
            id: lineSplitter
            height : 1
            color: "#1c1f1f"
            anchors.top: contextLbl.bottom
            anchors.right: parent.right;
            anchors.left: parent.left;
            anchors.topMargin: 9
            visible: expand
        }

        Rectangle
        {
            id: pane
            color: "#262a2b"
            anchors.top: lineSplitter.bottom
            anchors.right: parent.right;
            anchors.left: parent.left;
            anchors.bottom: parent.bottom;
            visible: expand
        }

        Rectangle
        {
            id: inputPane
            color: "#d9d9d9"
            anchors.top: pane.top
            anchors.right: parent.right;
            anchors.left: parent.left;
            anchors.bottom: parent.bottom;

            anchors.topMargin: 8
            anchors.bottomMargin: 8
            anchors.rightMargin: 25
            anchors.leftMargin: 20

            radius:6
            visible: expand
        }

        TextInput
        {
            z:5
            id: inputBox
            anchors.right: inputPane.right;
            anchors.left: inputPane.left;

            anchors.topMargin: 5
            anchors.verticalCenter: inputPane.verticalCenter
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            text: "hi"
            cursorVisible: true
            selectByMouse: true
            selectionColor: "#308cc6"
            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.IBeamCursor
                acceptedButtons: Qt.NoButton
            }
            visible: expand

            onAccepted: addPhSignal(title,inputBox.text)
        }

    }


    Timer {
        id:timeoutTimr
        interval: 150000; running: false; repeat: false
        onTriggered: notif.hide()
    }

    function startNotif() {
        timeoutTimr.restart();
        notif.height = 60;
        expand = false;
    }

    function expandNotif() {
        notif.height = 110;
        expand = true;
        notif.raise();
        notif.requestActivate();
        inputBox.forceActiveFocus();
        inputBox.text = ""
    }



    //Signals:
    signal addPhSignal(string title,string word)

    //Property
    property bool expand: false //this value get updated on start (in c sources)
    property int x_base: 0 //this value get updated on start (in c sources)
    property int y_base: 0 //this value get updated on start (in c sources)
    property string context: 'text' //this value get updated on start (in c sources)
    property string title: 'title' //this value get updated on start (in c sources)
    property string description: '(this word is not in \"phrasebook\")' //this value get updated on start (in c sources)
    visible: false
}

