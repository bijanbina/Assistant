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
    property variant isHighlighted: [0, 0, 0, 0]
    property variant word_l: ["", "", "", ""]
    property variant word_r: ["", "", "", ""]
    property variant word_i: [0, 0, 0, 0]
    property variant word_h: [0, 0, 0, 0]
    property variant color_s: ["#bbb", "#bbb", "#bbb", "#bbb"]
    signal mouseOnSound()
    signal clickedMe()

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Row
    {
        id: row
        anchors.fill: parent

        WordButton
        {
            width: parent.width/4
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            word_index: word_i[0]
            word_left: word_l[0]
            word_right: word_r[0]
            isHighlighted: word_h[0]
            soundColor: color_s[0]
        }

        WordButton
        {
            width: parent.width/4
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            word_index: word_i[1]
            word_left: word_l[1]
            word_right: word_r[1]
            isHighlighted: word_h[1]
            soundColor: color_s[1]
        }

        WordButton
        {
            width: parent.width/4
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            word_index: word_i[2]
            word_left: word_l[2]
            word_right: word_r[2]
            isHighlighted: word_h[2]
            soundColor: color_s[2]
        }

        WordButton
        {
            width: parent.width/4
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            word_index: word_i[3]
            word_left: word_l[3]
            word_right: word_r[3]
            isHighlighted: word_h[3]
            soundColor: color_s[3]
        }
    }



}

