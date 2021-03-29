import QtQuick 2.0

Rectangle
{
    property variant worda_l: ["", "", "", ""]
    property variant worda_r: ["", "", "", ""]
    property variant worda_i: [0, 0, 0, 0]
    property variant worda_h: [0, 0, 0, 0]

    property real height_item_pcview: root.height * 0.114

    ListView
    {
        id: pc_view
        anchors.fill: parent
        clip: true
        focus: focus_list && root.pc_mode
        interactive: false
        model: ListModel
        {
            id: list_pc
        }

        delegate: WordButton4
        {
            width: root.width
            height: height_item_pcview
            word_l: [word1, word2, word3, word4]
            word_r: [translate1, translate2, translate3, translate4]
            word_i: [index_m1, index_m2, index_m3, index_m4]
            word_h: [highlight1, highlight2, highlight3, highlight4]
            color_s: [sColor1, sColor2, sColor3, sColor4]
            onClickWord:
            {
                updateHighlight(indx)
            }
        }

        Keys.onPressed:
        {
            if ( event.key===Qt.Key_Up )
            {
                fastScrollUp(7)
            }
            else if ( event.key===Qt.Key_Down )
            {
                fastScrollDown(7)
            }
            else
            {
                root.key_detect(event.key)
            }
        }

        onContentYChanged:
        {
            updatePage()
        }

        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton

            onWheel:
            {
                var index = getLsConY()
                if(wheel.angleDelta.y<0)
                {
                    fastScrollDown(2)
                }
                else
                {
                    fastScrollUp(2)
                }
            }
        }
    }

    ListView
    {
        id: search_view
        anchors.fill: parent
        z: 2
        visible: false
        model: ListModel
        {
            id: list_search
        }

        delegate: WordButton
        {
            width: root.width
            height: root.height * 0.125
            word_left: word
            word_right: translate
            word_index: index_m
            word_highlighted: highlight
            soundColor: sColor
//            onMouseOnSound:
//            {
//                //change sColor only for clicked cell
//                sColor = "#2aba89"
//                sayWord_search(index_i) //this cannot replace with word. because after "sayWord"
//                // complete playing the prononciation if we don't have index we can't replace
//                // sound icon color back.
//            }
         }
    }

    function addList(highlight, index, word, translate)
    {
        worda_i[index%4] = index
        worda_l[index%4] = word
        worda_r[index%4] = translate
        if ( highlight )
        {
            worda_h[index%4] = 1
        }
        else
        {
            worda_h[index%4] = 0
        }

        if( index%4 === 0 )
        {
            list_pc.append({ "index_m1" : worda_i[1], "word1" : worda_l[1],
                            "translate1" : worda_r[1], "highlight1" : worda_h[1],
                             "index_m2" : worda_i[2], "word2" : worda_l[2],
                            "translate2" : worda_r[2], "highlight2" : worda_h[2],
                             "index_m3" : worda_i[3], "word3" : worda_l[3],
                            "translate3" : worda_r[3], "highlight3" : worda_h[3],
                             "index_m4" : worda_i[0], "word4" : worda_l[0],
                            "translate4" : worda_r[0], "highlight4" : worda_h[0],
                            "sColor1" : "#bbb", "sColor2" : "#bbb",
                            "sColor3" : "#bbb", "sColor4" : "#bbb"});
        }
    }

    function en_search_show(text, isClear)
    {
        var i = 0;
        var rc = 0;
        var max_size = list_search.count;
        //remove all previous search
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (list_search.get(i-rc).word.indexOf(text) == -1 || isClear )
            {
                list_search.remove(i-rc);
                rc = rc + 1;
            }
            else
            {
                list_search.get(i-rc).index_i = i-rc+1
            }
        }

        if (isClear)
        {
            max_size = list_backup.count;
            rc = 0;
            for ( i = 0 ; i < max_size ; i=i+1 )
            {
                if (list_backup.get(i).word.indexOf(text) !== -1 )
                {
                    rc = rc +1;
                    list_search.append({"index_i" : rc , "word" : list_backup.get(i).word,
                                        "translate" : list_backup.get(i).translate, "highlight" : 0,
                                        "sColor" : "#bbb", "index_m" : i});
                }
            }
        }
    }

    function fa_search_show(text, isClear)
    {
        var i = 0;
        var rc = 0;
        var max_size = list_search.count;
        //remove all previous search
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (list_search.get(i-rc).translate.indexOf(text) == -1 || isClear )
            {
                list_search.remove(i-rc);
                rc = rc + 1;
            }
            else
            {
                list_search.get(i-rc).index_i = i-rc+1
            }
        }
        if (isClear)
        {
            rc = 0
            max_size = list_backup.count;
            for ( i = 0 ; i < max_size ; i=i+1 )
            {
                if (list_backup.get(i).translate.indexOf(text) !== -1 )
                {
                    rc = rc +1;
                    list_search.append({"index_i" : rc , "word" : list_backup.get(i).word,
                                           "translate" : list_backup.get(i).translate, "highlight" : 0,
                                           "sColor" : "#bbb", "index_m" : i});
                }
            }
        }
    }

    function removeList()
    {
        var return_val = 0
        var i = 0
        var max_size = getLsCount()
        var rc = 0 //removed element counter
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (highlight_string[i] === 'f' )
            {
                list_pc.remove(i-rc)
                rc = rc + 1
            }
            else if ( word1 === list_el.get(i-rc).word )
            {
                return_val = i-rc;
                list_pc.get(i-rc).index_i =  i-rc+1;
            }
            else
            {
                list_el.get(i-rc).index_i =  i-rc+1;
            }

        }
        return return_val;
    }

    function restoreList()
    {
        var return_val = 0;
        var i = 0;
        var max_size = list_backup.count;
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (highlight_string[i] === 'f' )
            {
                //index used for sayword
                list_el.insert(i, {"index_i" : i+1 , "word" : list_backup.get(i).word,
                                       "translate" : list_backup.get(i).translate, "highlight" : 0,
                                       "sColor" : "#bbb"})
            }
            else if ( word1 === list_backup.get(i).word )
            {
                return_val = i;
                list_el.get(i).index_i =  i+1;
            }
            else
            {
                list_el.get(i).index_i =  i+1;
            }

        }
        return return_val;
    }

    function forceView(ind)
    {
        pc_view.positionViewAtIndex(ind , ListView.Beginning)
    }

    function getLsConY()
    {
        return pc_view.indexAt(10, pc_view.contentY+height_item_pcview/2);
    }

    function getLsCount()
    {
        return list_pc.count;
    }

    function showSearchView()
    {
        search_view.visible = true
        pc_view.visible = false
    }

    function hideSearchView()
    {
        search_view.visible = false
        pc_view.visible = true
    }

    function pronStopped(index)
    {
        if ( index%4 === 1 )
        {
            list_pc.get(index/4).sColor1 = "#bbb"
        }
        else if( index%4 === 2 )
        {
            list_pc.get(index/4).sColor2 = "#bbb"
        }
        else if( index%4 === 3 )
        {
            list_pc.get(index/4).sColor3 = "#bbb"
        }
        else if( index%4 === 0 )
        {
            list_pc.get(index/4-1).sColor4 = "#bbb"
        }
    }

    function pronError(index)
    {
        var fg_color = "#cd4646"
        if ( index%4 === 1 )
        {
            list_pc.get(index/4).sColor1 = fg_color
        }
        else if( index%4 === 2 )
        {
            list_pc.get(index/4).sColor2 = fg_color
        }
        else if( index%4 === 3 )
        {
            list_pc.get(index/4).sColor3 = fg_color
        }
        else if( index%4 === 0 )
        {
            list_pc.get(index/4-1).sColor4 = fg_color
        }
    }

    ///FIXME
    function pronStoppedSearch(index)
    {
        list_search.get(index-1).sColor = "#bbb"
    }

    function fastScrollUp(num)
    {
        var index_beginnig = getLsConY()
        if( index_beginnig < num)
        {
            pc_view.positionViewAtBeginning()
        }
        else
        {
            pc_view.positionViewAtIndex(index_beginnig - num, ListView.Beginning)
        }
    }

    function fastScrollDown(num)
    {
        var index_beginnig = getLsConY()
        var list_count = getLsCount()
        if( index_beginnig+num > list_count)
        {
            pc_view.positionViewAtEnd()
        }
        else
        {
            pc_view.positionViewAtIndex(index_beginnig + num, ListView.Beginning)
        }
    }

    function changeStarMode()
    {
        var item
        if(root.star_mode)
        {
            list_pc.clear()
            var row_index=1
            var cnt=0 //number of highlighted
            for(var i=0; i<highlight_string.length; i++)
            {
                if(highlight_string[i] === 't' )
                {
                    cnt++
                    item = list_backup.get(i)
                    worda_i[row_index%4] = cnt
                    worda_l[row_index%4] = item.word
                    worda_r[row_index%4] = item.translate
                    worda_h[row_index%4] = 1

                    if( row_index%4 === 0 )
                    {
                        list_pc.append({ "index_m1" : worda_i[1], "word1" : worda_l[1],
                                        "translate1" : worda_r[1], "highlight1" : worda_h[1],
                                         "index_m2" : worda_i[2], "word2" : worda_l[2],
                                        "translate2" : worda_r[2], "highlight2" : worda_h[2],
                                         "index_m3" : worda_i[3], "word3" : worda_l[3],
                                        "translate3" : worda_r[3], "highlight3" : worda_h[3],
                                         "index_m4" : worda_i[0], "word4" : worda_l[0],
                                        "translate4" : worda_r[0], "highlight4" : worda_h[0],
                                        "sColor1" : "#bbb", "sColor2" : "#bbb",
                                        "sColor3" : "#bbb", "sColor4" : "#bbb"});
                    }
                    row_index++
                }
            }
            if(cnt%4===1)
            {
                worda_i[2] = 0
                worda_l[2] = ""
                worda_r[2] = ""
                worda_h[2] = 0
                worda_i[3] = 0
                worda_l[3] = ""
                worda_r[3] = ""
                worda_h[3] = 0
                worda_i[0] = 0
                worda_l[0] = ""
                worda_r[0] = ""
                worda_h[0] = 0
            }
            else if(cnt%4===2)
            {
                worda_i[3] = 0
                worda_l[3] = ""
                worda_r[3] = ""
                worda_h[3] = 0
                worda_i[0] = 0
                worda_l[0] = ""
                worda_r[0] = ""
                worda_h[0] = 0
            }
            else if(cnt%4===3)
            {
                worda_i[0] = 0
                worda_l[0] = ""
                worda_r[0] = ""
                worda_h[0] = 0
            }

            list_pc.append({ "index_m1" : worda_i[1], "word1" : worda_l[1],
                            "translate1" : worda_r[1], "highlight1" : worda_h[1],
                             "index_m2" : worda_i[2], "word2" : worda_l[2],
                            "translate2" : worda_r[2], "highlight2" : worda_h[2],
                             "index_m3" : worda_i[3], "word3" : worda_l[3],
                            "translate3" : worda_r[3], "highlight3" : worda_h[3],
                             "index_m4" : worda_i[0], "word4" : worda_l[0],
                            "translate4" : worda_r[0], "highlight4" : worda_h[0],
                            "sColor1" : "#bbb", "sColor2" : "#bbb",
                            "sColor3" : "#bbb", "sColor4" : "#bbb"})
        }
        else
        {
            list_pc.clear()
            var hl = 0 //highlight
            for(var j=0; j<list_backup.count; j++)
            {
                if(highlight_string[j]==='f')
                {
                    hl = 0
                }
                else
                {
                    hl = 1
                }
                item = list_backup.get(j)
                addList(hl, item.index_i, item.word, item.translate)
            }
        }
    }



    function playPron(indx)
    {
        var item = list_pc.get((indx-1)/4)
        var index_row = indx%4
        var wordLeft

        if(index_row===1)
        {
            wordLeft = item.word1
            list_pc.get(index_row).sColor1 = "#2aba89"
        }
        else if(index_row===2)
        {
            wordLeft = item.word2
            list_pc.get(index_row).sColor2 = "#2aba89"
        }
        else if(index_row===3)
        {
            wordLeft = item.word3
            list_pc.get(index_row).sColor3 = "#2aba89"
        }
        else if(index_row===0)
        {
            wordLeft = item.word4
            list_pc.get(index_row).sColor4 = "#2aba89"
        }

        playMusic.source = root.mp3_path + wordLeft + ".mp3"
        playMusic.play()

        root.index_m = indx;
        mouseOnSound()
    }

    function updateHighlight(indx)
    {
        var item = list_pc.get((indx-1)/4)
        var index_row = indx%4
        var wordLeft
        var wordRight

        if(index_row===1)
        {
            wordLeft = item.word1
            wordRight = item.translate1
        }
        else if(index_row===2)
        {
            wordLeft = item.word2
            wordRight = item.translate2
        }
        else if(index_row===3)
        {
            wordLeft = item.word3
            wordRight = item.translate3
        }
        else if(index_row===0)
        {
            wordLeft = item.word4
            wordRight = item.translate4
        }

        if(root.star_mode)
        {
            if(index_row===1)
            {
                if(item.highlight1===1)
                {
                    item.highlight1 = 2
                }
                else
                {
                    item.highlight1 = 1
                }
            }
            else if(index_row===2)
            {
                if(item.highlight2===1)
                {
                    item.highlight2 = 2
                }
                else
                {
                    item.highlight2 = 1
                }
            }
            else if(index_row===3)
            {
                if(item.highlight3===1)
                {
                    item.highlight3 = 2
                }
                else
                {
                    item.highlight3 = 1
                }
            }
            else if(index_row===0)
            {
                if(item.highlight4===1)
                {
                    item.highlight4 = 2
                }
                else
                {
                    item.highlight4 = 1
                }
            }
        }
        else
        {
            if(index_row===1)
            {
                if(item.highlight1===1)
                {
                    item.highlight1 = 0
                }
                else if(item.highlight1===0)
                {
                    item.highlight1 = 1
                }
            }
            else if(index_row===2)
            {
                if(item.highlight2===1)
                {
                    item.highlight2 = 0
                }
                else if(item.highlight2===0)
                {
                    item.highlight2 = 1
                }
            }
            else if(index_row===3)
            {
                if(item.highlight3===1)
                {
                    item.highlight3 = 0
                }
                else if(item.highlight3===0)
                {
                    item.highlight3 = 1
                }
            }
            else if(index_row===0)
            {
                if(item.highlight4===1)
                {
                    item.highlight4 = 0
                }
                else if(item.highlight4===0)
                {
                    item.highlight4 = 1
                }
            }


        }

        //change setting (f char=false, t char = true)
        if (highlight_string[indx-1] === 'f' )
        {
            highlight_string = highlight_string.substr(0, indx-1) + 't' + highlight_string.substr(indx);
            var last_ind = indx-2
            for ( ; last_ind >= 0 ; last_ind-- )
            {
                if (highlight_string[last_ind] !== 'f' )
                {
                    break;
                }
            }
            if( last_ind<0 )
            {
                add_highlight(wordLeft, "")
            }
            else
            {
                var last_word

                if ( last_ind%4 == 0 )
                {
                    last_word = list_pc.get(last_ind/4).word1
                }
                else if ( last_ind%4 == 1 )
                {
                    last_word = list_pc.get(last_ind/4).word2
                }
                else if ( last_ind%4 == 2 )
                {
                    last_word = list_pc.get(last_ind/4).word3
                }
                else if ( last_ind%4 == 3 )
                {
                    last_word = list_pc.get(last_ind/4).word4
                }

                add_highlight(wordLeft, last_word)
            }
        }
        else
        {
            highlight_string = highlight_string.substr(0, indx-1) + 'f' + highlight_string.substr(indx);
            remove_highlight(wordLeft)
        }
    }

}
