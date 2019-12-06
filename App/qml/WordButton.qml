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
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

Rectangle {
    property bool pressed: false
    property real isHighlighted
    property string word_left
    property string word_right
    property int word_index
    property color fontColor
    property string soundColor : "#bbb"
    signal mouseOnSound()
    signal clickedMe()
    id: control

    gradient: Gradient {
        GradientStop {
            id: grad_back
            color: if (isHighlighted == 1)
                   {
                        "#033"
                   }
                   else if (isHighlighted == 2)
                   {
                        "#4d3800"
                   }
                   else //not highlighted
                   {
                       if (pressed)
                           "#222"
                       else
                           "#333"
                   }

            position: 0
        }
        GradientStop {
            color: "#222"
            position: 1
        }
    }
    /*Rectangle {
        height: 1
        width: parent.width
        anchors.top: parent.top
        color: "#444"
        visible: !pressed
    }
    Rectangle {
        height: 1
        width: parent.width
        anchors.bottom: parent.bottom
        color: "#000"
    }*/
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight
    baselineOffset: row.y + text.y + text.baselineOffset

    Rectangle
    {
        property int border_width : 4
        property color border_color : "#1f1f1f"
        Rectangle
        {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: parent.border_width
            //color: grad_back.color
            color: parent.border_color
        }
        id: label_index
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: control.width * 0.05
        height: control.height
        color: "#252525"
        Text {
            anchors.left: parent.left
            anchors.leftMargin: if ( word_index<100 )
                                {
                                    5
                                }
                                else if ( word_index<1000 )
                                {
                                    0
                                }
                                else
                                {
                                    -3
                                }

            text: word_index
            color: fontColor
            font.pixelSize: control.height * 0.15
            font.family: openSans.name

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: 90
        }
        Rectangle
        {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: parent.border_width * 0
            color: parent.border_color
        }
        Rectangle
        {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.border_width
            color: parent.border_color
        }
    }
    Row {
        id: row
        anchors.left: label_index.right
        anchors.leftMargin: textSingleton.implicitHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: text
            text: word_left
            color: fontColor
            font.pixelSize: control.height * 0.2
            font.family: openSans.name
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Text {
        id: label_right
        text: word_right
        color: fontColor
        font.pixelSize: control.height * 0.2
        font.family: openSans.name
        anchors.right: parent.right
        anchors.rightMargin: textSingleton.implicitHeight

        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle
    {
        //id: sound button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: control.width * 0.15
        height: control.height * 0.8
        opacity: 0.1
        color: "#777"
        z:5
    }

    Rectangle
    {
        //id: sound button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: control.width * 0.15
        height: control.height * 0.8
        color: "transparent"
        Text {
            opacity: 1
            id: label_center
            text: "\uf028"
            color: soundColor
            font.pixelSize: control.height * 0.22
            font.family: fontAwesome.name
            font.weight: Font.Black
            anchors.horizontalCenter: parent.horizontalCenter

            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:{
                mouseOnSound()
            }
        }
        z:10
    }


    MouseArea
    {
        anchors.fill: parent
        onClicked:{
            clickedMe()
        }
    }



}

