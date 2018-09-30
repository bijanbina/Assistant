/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
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

    color: "#161616"
    title: "Qt Quick Extras Demo"

    function toPixels(percentage)
    {
        return percentage * Math.min(root.width, root.height);
    }

    property bool isScreenPortrait: height > width
    property color lightFontColor: "#222"
    property color darkFontColor: "#e7e7e7"
    readonly property color lightBackgroundColor: "#cccccc"
    readonly property color darkBackgroundColor: "#161616"
    property real customizerPropertySpacing: 10
    property real colorPickerRowSpacing: 8
    property string word1 : "word1"
    property string word2 : "word2"
    property int index_val : 1
    property int index_m : 1


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
        onStopped: list_el.get(index_m-1).sColor = "#bbb"
    }


    Rectangle
    {
        height: 0.9 * parent.height
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top;
        id: rec1
        ListView
        {
            id: lsview
            anchors.fill: parent
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

                fontColor: root.darkFontColor
                isHighlighted: highlight
                soundColor: sColor
                onMouseOnSound:
                {
                    sayWord(index_i)
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
             focus: true

             onContentYChanged: updatePage(Math.round(lsview.contentY/(root.height * 0.125)))
             //onContentHeightChanged: {lsview.contentY = (settings.ls_cony)*100.0}
             onWidthChanged: {
                 lsview.contentY = (settings.ls_cony)*100.0;
                 //updatePage(Math.round((settings.ls_cony)*100.0/(root.height * 0.125)));
             }
        }
    }

    Rectangle
    {
        height: parent.height - rec1.height
        width: parent.width
        anchors.left: parent.left
        anchors.top: rec1.bottom
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
                    lsview.contentY = lsview.contentY - 25*(root.height * 0.125);
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
                    if (lsview.contentY + 25 * (root.height * 0.125) > (lsview.contentHeight-root.height))
                        lsview.contentY = lsview.contentHeight - root.height;
                    else
                       lsview.contentY = lsview.contentY + 25 * (root.height * 0.125)
                }
            }
        }
    }

    function addList() {
        if (settings.card_highlight[index_val-1] == 'f' )
        {
            list_el.append({"index_i" : index_val , "word" : word1,
                           "translate" : word2, "highlight" : false,
                           "sColor" : "#bbb"});
        }
        else
        {
            list_el.append({"index_i" : index_val , "word" : word1,
                           "translate" : word2, "highlight" : true,
                           "sColor" : "#bbb"});
        }
    }

    function changecl(ind)
    {
        list_el.get(ind-1).highlight = !(list_el.get(ind-1).highlight)
        if (settings.card_highlight[ind-1] == 'f' )
        {
            settings.card_highlight = settings.card_highlight.substr(0, ind-1) + 't' + settings.card_highlight.substr(ind);
        }
        else
        {
            settings.card_highlight = settings.card_highlight.substr(0, ind-1) + 'f' + settings.card_highlight.substr(ind);
        }
    }

    function sayWord(ind)
    {
        list_el.get(ind-1).sColor = "#2aba89"
        playMusic.source = "file:///home/bijan/Project/Assistant/Scripts/MP3/" + list_el.get(ind-1).word + ".mp3"
        playMusic.play()
        index_m = ind;
    }

    function forceView(ind)
    {
        //lsview.positionViewAtIndex(ind, ListView.Center)
        lsview.positionViewAtIndex(ind, ListView.End)
    }

    Settings
    {
        id: settings
        property double ls_cony: 0//Math.round(lsview.contentY/100)
        property string card_highlight
    }

    Component.onDestruction: {
        settings.ls_cony = Math.round(lsview.contentY/100)
    }


    function itemAdded()
    {
        //forceView(3000)
        //lsview.contentY = (5000)*100.0
        //updatePage(Math.round(lsview.contentY/(root.height * 0.125)))
        updatePage(root.height)
        if (settings.card_highlight.length<6000)
                {
                    var t = new String
                    for (var i = 0; i < 6000; i++)
                    {
                        t = t.concat('f')
                    }
                    settings.card_highlight = t;
                    console.log (settings.card_highlight.length)
                }
    }

    function updatePage(contenty)
    {
        status.text = contenty + " / " +
                Math.round((lsview.contentHeight/(root.height * 0.125))-8) +
                "\nV0.5 - Settings: " + settings.ls_cony;
    }


}


