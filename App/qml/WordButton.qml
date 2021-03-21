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

Rectangle
{
    id: control

    //"file:///home/bijan/Project/Assistant/Scripts/MP3/"
    //"file:///O:/Projects/Assistant/Scripts/MP3/"
    //"file:///storage/emulated/0/BIC/MP3/"
    property string mp3_path: "file:mp3/"
    property string word_left
    property string word_right
    property int word_index
    property int word_highlighted: 0 //1 -> highlighted, 2 -> in favorite mode hilighted, otherwise not highlighted

    property color fontColor: root.darkFontColor
    property color soundColor : "#bbb"

    property color color_background_gradient:
    {
        if ( word_highlighted===1 )
        {
            "#033"
        }
        else if ( word_highlighted===2 )
        {
            "#4d3800"
        }
        else //not highlighted
        {
            "#333"
        }
    }

    property real width_rect_index: control.width * 0.05
    property real height_rect_index: control.height
    property color color_background_rect_index: "#252525"

    property color color_label_index: fontColor
    property real pixel_size_label_index: control.height * 0.15
    property string font_name_label_index: openSans.name

    property real pixel_size_label_left: control.height * 0.2
    property color color_label_left: fontColor
    property string font_name_label_left: openSans.name

    property real width_rect_sound_btn: control.width * 0.15
    property real height_rect_sound_btn: control.height * 0.8
    property color color_rect_background_sound_btn: "#777"

    property string text_label_sound: "\uf028"
    property color color_label_sound: soundColor
    property real pixel_size_label_sound: control.height * 0.22
    property string font_name_label_sound: fontAwesome.name
    property int font_weight_label_sound: Font.Black

    property real pixel_size_label_right: control.height * 0.2
    property color color_label_right: fontColor
    property string font_name_label_right: openSans.name

    signal mouseOnSound()
    signal clickedWord(int indx, string wordLeft, string wordRight, int highlight)


    gradient: Gradient
    {
        GradientStop
        {
            id: grad_back
            color: color_background_gradient
//            {
//                if ( word_highlighted===1 )
//                {
//                    "#033"
//                }
//                else if ( word_highlighted===2 )
//                {
//                    "#4d3800"
//                }
//                else //not highlighted
//                {
//                    "#333"
//                }
//            }

            position: 0
        }

        GradientStop
        {
            color: "#222"
            position: 1
        }
    }

    Rectangle
    {
        property int border_width : 4
        property color border_color : "#1f1f1f"

        id: rect_index
        width: width_rect_index
        height: height_rect_index
        anchors.left: parent.left
        color: color_background_rect_index

        Rectangle
        {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: parent.border_width
            color: parent.border_color
        }

        Text
        {
            id: label_index
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: 90
            text: word_index
            color: color_label_index
            font.pixelSize: pixel_size_label_index
            font.family: font_name_label_index
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

    Text
    {
        id: label_left
        anchors.left: rect_index.right
        anchors.leftMargin: textSingleton.implicitHeight
        anchors.verticalCenter: parent.verticalCenter
        text: word_left
        color: color_label_left
        font.pixelSize: pixel_size_label_left
        font.family: font_name_label_left
    }

    Text
    {
        id: label_right
        anchors.right: parent.right
        anchors.rightMargin: textSingleton.implicitHeight
        anchors.verticalCenter: parent.verticalCenter
        text: word_right
        color: color_label_right
        font.pixelSize: pixel_size_label_right
        font.family: font_name_label_right
    }

    Rectangle
    {
        id: rect_sound
        width: width_rect_sound_btn
        height: height_rect_sound_btn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Rectangle
        {
            id: rect_background_sound_btn
            anchors.fill: parent
            color: color_rect_background_sound_btn
            opacity: 0.1
        }

        Text
        {
            id: label_sound
            opacity: 1
            text: text_label_sound
            color: color_label_sound
            font.pixelSize: pixel_size_label_sound
            font.family: font_name_label_sound
            font.weight: font_weight_label_sound
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea
        {
            anchors.fill: parent
            z: 5
            onClicked: playPron()
            onEntered: playPron()
            hoverEnabled: root.pc_mode
        }

    }

    MouseArea
    {
        anchors.fill: parent
        z: -5

        onClicked:
        {
            clickedWord(word_index, word_left, word_right, word_highlighted)
        }
    }

    function playPron()
    {
        if(pc_mode)
        {
            playMusic.source = mp3_path + word_left + ".mp3"
            console.log("source file music", playMusic.source)
        }
        else
        {
            playMusic.source = mp3_path + word_left + ".mp3"
        }
        playMusic.play()
        root.index_m = word_index;
        mouseOnSound()
    }

}

