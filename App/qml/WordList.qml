import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.0
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.1
import Qt.labs.settings 1.0
import QtMultimedia 5.5

Rectangle
{
    property variant worda_l: ["", "", "", ""]
    property variant worda_r: ["", "", "", ""]
    property variant worda_i: [0, 0, 0, 0]
    property variant worda_h: [0, 0, 0, 0]

    ListView
    {
        id: lsview
        anchors.fill: parent
        headerPositioning: ListView.PullBackHeader
        visible: pc_mode
        model: ListModel
        {
            id: list_el
        }

        delegate: WordButton
        {
            width: root.width
            height: root.height * 0.125
            word_left: word
            word_right: translate
            word_index: index_i

            fontColor: root.darkFontColor
            isHighlighted: highlight
            soundColor: sColor
            onMouseOnSound:
            {
                //change sColor only for clicked cell
                sColor = "#2aba89"
                sayWord(index_i) //this cannot replace with word. because after "sayWord"
                // complete playing the prononciation if we don't have index we can't replace
                // sound icon color back.
            }

            onClickedMe:
            {
                    // Only push the control view if we haven't already pushed it...
                    //addList()
                    changecl(index_i);
                    //forceView(3000)
            }

         }
         Keys.onPressed:
         {
            if ( event.key==Qt.Key_Up )
            {
                //console.log("move up");
                lsview.contentY = lsview.contentY - 100
                event.accepted = true;
            }
            else if ( event.key == Qt.Key_Down )
            {
                //console.log("move up");
                if (lsview.contentY + 100 > (lsview.contentHeight-root.height))
                    lsview.contentY = lsview.contentHeight - root.height;
                else
                   lsview.contentY = lsview.contentY + 100
                event.accepted = true;
            }
            else if ( event.key==Qt.Key_Space )
            {
                //console.log("move up");
                if (lsview.contentY + 100 > (lsview.contentHeight-root.height))
                    lsview.contentY = lsview.contentHeight - root.height;
                else
                   lsview.contentY = lsview.contentY + 100
                event.accepted = true;
            }
         }
         //focus: true

         onContentYChanged: updatePage()
         //onContentHeightChanged: {lsview.contentY = (settings.ls_cony)*100.0}
         onWidthChanged:
         {
             //lsview.contentY = (settings.ls_cony)*100.0;
             //updatePage(Math.round((settings.ls_cony)*100.0/(root.height * 0.125)));
         }
    }

    ListView
    {
        id: search_view
        anchors.fill: parent
        headerPositioning: ListView.PullBackHeader
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

            fontColor: root.darkFontColor
            isHighlighted: 0
            soundColor: sColor
            onMouseOnSound:
            {
                //change sColor only for clicked cell
                sColor = "#2aba89"
                sayWord_search(index_i) //this cannot replace with word. because after "sayWord"
                // complete playing the prononciation if we don't have index we can't replace
                // sound icon color back.
            }
         }
    }

    ListView
    {
        id: pc_view
        width: root.width
        height: root.height * 0.8
        anchors.left: parent.left
        anchors.top: topBar.bottom
        headerPositioning: ListView.PullBackHeader
//        z: 2
        visible: pc_mode
        model: ListModel
        {
            id: list_pc
        }

        delegate: WordButton4
        {
            width: root.width
            height: root.height * 0.114
            word_l: [word1, word2, word3, word4]
            word_r: [translate1, translate2, translate3, translate4]
            word_i: [index_m1, index_m2, index_m3, index_m4]
            word_h: [highlight1, highlight2, highlight3, highlight4]
            color_s: [sColor1, sColor2, sColor3, sColor4]
         }

        Keys.onPressed:
        {
           console.log("move up");
           if (event.key == Qt.Key_Up)
           {
               fastScrollUp(6)
               event.accepted = true;
           }
           if (event.key == Qt.Key_Down)
           {
               //console.log("move up");
               fastScrollDown(6)
               event.accepted = true;
           }
        }

        focus: true

        onContentYChanged:
        {
            forceActiveFocus()
            updatePage()
        }
    }

    function addList(highlight, index, word, translate)
    {
        if( pc_mode )
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
                list_pc.append({"index_m1" : worda_i[1] , "word1" : worda_l[1],
                                "translate1" : worda_r[1], "highlight1" : worda_h[1],
                                "index_m2" : worda_i[2] , "word2" : worda_l[2],
                                "translate2" : worda_r[2], "highlight2" : worda_h[2],
                                "index_m3" : worda_i[3] , "word3" : worda_l[3],
                                "translate3" : worda_r[3], "highlight3" : worda_h[3],
                                "index_m4" : worda_i[0] , "word4" : worda_l[0],
                                "translate4" : worda_r[0], "highlight4" : worda_h[0],
                                "sColor1" : "#bbb", "sColor2" : "#bbb",
                                "sColor3" : "#bbb", "sColor4" : "#bbb"});
            }
        }
        else
        {
            if ( !highlight )
            {
                list_el.append({"index_i" : index , "word" : word,
                                "translate" : translate, "highlight" : 0,
                                "sColor" : "#bbb"});
            }
            else
            {
                list_el.append({"index_i" : index , "word" : word,
                               "translate" : translate, "highlight" : 1,
                               "sColor" : "#bbb"});
            }
            list_backup.append({"index_i" : index , "word" : word, "translate" : translate});
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
        var return_val = 0;
        var i = 0;
        var max_size = list_el.count;
        var rc = 0; //removed element counter
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (highlight_string[i] == 'f' )
            {
                list_el.remove(i-rc);
                rc = rc + 1;
            }
            else if ( word1 == list_el.get(i-rc).word )
            {
                return_val = i-rc;
                list_el.get(i-rc).index_i =  i-rc+1;
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
            if (highlight_string[i] == 'f' )
            {
                //index used for sayword
                list_el.insert(i, {"index_i" : i+1 , "word" : list_backup.get(i).word,
                                       "translate" : list_backup.get(i).translate, "highlight" : 0,
                                       "sColor" : "#bbb"})
            }
            else if ( word1 == list_backup.get(i).word )
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

    //Chnage color of index
    function changecl(ind)
    {
        var list_word
        if( pc_mode )
        {
            if (!star_mode) //no change color in starmode
            {
                //toggle color on ui
                if ( ind%4 == 1 )
                {
                    list_word = list_pc.get(ind/4).word1
                    if ( list_pc.get(ind/4).highlight1 === 1)
                    {
                        list_pc.get(ind/4).highlight1 = 0
                    }
                    else
                    {
                        list_pc.get(ind/4).highlight1 = 1
                    }
                }
                else if ( ind%4 == 2 )
                {
                    list_word = list_pc.get(ind/4).word2
                    if ( list_pc.get(ind/4).highlight2 === 1)
                    {
                        list_pc.get(ind/4).highlight2 = 0
                    }
                    else
                    {
                        list_pc.get(ind/4).highlight2 = 1
                    }
                }
                else if ( ind%4 == 3 )
                {
                    list_word = list_pc.get(ind/4).word3
                    if ( list_pc.get(ind/4).highlight3 === 1)
                    {
                        list_pc.get(ind/4).highlight3 = 0
                    }
                    else
                    {
                        list_pc.get(ind/4).highlight3 = 1
                    }
                }
                else if ( ind%4 == 4 )
                {
                    list_word = list_pc.get(ind/4).word4
                    if ( list_pc.get(ind/4).highlight4 === 1)
                    {
                        list_pc.get(ind/4).highlight4 = 0
                    }
                    else
                    {
                        list_pc.get(ind/4).highlight4 = 1
                    }
                }


            }
            else //in star_mode
            {
                if ( list_el.get(ind-1).highlight == 2)
                {
                    list_el.get(ind-1).highlight = 1
                }
                else
                {
                    list_el.get(ind-1).highlight = 2
                }
            }
        }
        else
        {
            if (!star_mode) //no change color in starmode
            {
                list_word = list_el.get(ind-1).word

                //toggle color on ui
                if ( list_word.get(ind-1).highlight == 1)
                {
                    list_word.get(ind-1).highlight = 0
                }
                else
                {
                    list_el.get(ind-1).highlight = 1
                }
            }
            else //in star_mode
            {
                if ( ind%4 == 1 )
                {
                    if ( list_pc.get(ind/4).highlight1 === 2)
                    {
                        list_pc.get(ind/4).highlight1 = 1
                    }
                    else
                    {
                        list_pc.get(ind/4).highlight1 = 2
                    }
                }
                else if ( ind%4 == 2 )
                {
                    if ( list_pc.get(ind/4).highlight2 === 2)
                    {
                        list_pc.get(ind/4).highlight2 = 1
                    }
                    else
                    {
                        list_pc.get(ind/4).highlight2 = 2
                    }
                }
                else if ( ind%4 == 3 )
                {
                    if ( list_pc.get(ind/4).highlight3 === 2)
                    {
                        list_pc.get(ind/4).highlight3 = 1
                    }
                    else
                    {
                        list_pc.get(ind/4).highlight3 = 2
                    }
                }
                else if ( ind%4 == 4 )
                {
                    if ( list_pc.get(ind/4).highlight4 === 2)
                    {
                        list_pc.get(ind/4).highlight4 = 1
                    }
                    else
                    {
                        list_pc.get(ind/4).highlight4 = 2
                    }
                }
            }
        }

        if (!star_mode) //no change color in starmode
        {
            //change setting (f char=false, t char = true)
            if (highlight_string[ind-1] == 'f' )
            {
                highlight_string = highlight_string.substr(0, ind-1) + 't' + highlight_string.substr(ind);
                var last_ind = ind-2
                for ( ; last_ind > 0 ; last_ind-- )
                {
                    if (highlight_string[last_ind] != 'f' )
                    {
                        break;
                    }
                }

                if ( last_ind == 0 )
                {
                    add_highlight(list_word, "")
                }
                else
                {
                    var last_word
                    if( pc_mode )
                    {
                        last_ind = last_ind + 1;

                        if ( last_ind%4 == 1 )
                        {
                            last_word = list_pc.get(last_ind/4).word1;
                        }
                        else if ( last_ind%4 == 2 )
                        {
                            last_word = list_pc.get(last_ind/4).word2;
                        }
                        else if ( last_ind%4 == 3 )
                        {
                            last_word = list_pc.get(last_ind/4).word3;
                        }
                        else if ( last_ind%4 == 4 )
                        {
                            last_word = list_pc.get(last_ind/4).word4;
                        }
                    }
                    else
                    {
                        last_word = list_el.get(last_ind).word;
                    }

                    add_highlight(list_word, last_word)
                }
            }
            else
            {
                highlight_string = highlight_string.substr(0, ind-1) + 'f' + highlight_string.substr(ind);
                remove_highlight(list_word)
            }
        }
    }

    function sayWord(ind)
    {
        index_m = ind;
    }

    function forceView(ind)
    {
        if( pc_mode )
        {
            pc_view.positionViewAtIndex(ind - 1, ListView.Beginning)
        }
        else
        {
            lsview.positionViewAtIndex(ind - 1, ListView.Beginning)
        }
    }

    function getLsConY()
    {
        if( pc_mode )
        {
            return pc_view.indexAt(10,pc_view.contentY) + 1;
        }
        else
        {
            return lsview.indexAt(10,lsview.contentY) + 1;
        }
    }

    function getLsCount()
    {
        if( pc_mode )
        {
            return list_pc.count;
        }
        else
        {
            return list_el.count;
        }
    }

    function showSearchView()
    {
        search_view.visible = true
        lsview.visible = false
    }

    function hideSearchView()
    {
        search_view.visible = false
        lsview.visible = true
    }

    function pronStopped(index)
    {
        if( pc_mode )
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
        else
        {
            list_el.get(index-1).sColor = "#bbb"
        }
    }

    function pronError(index)
    {
        var fg_color = "#cd4646"
        if( pc_mode )
        {
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
        else
        {
            list_el.get(index-1).sColor = fg_color
        }
    }

    function pronStoppedSearch(index)
    {
        list_search.get(index-1).sColor = "#bbb"
    }

    function fastScrollUp(num)
    {
        if (en_text.text.length > 2 || fa_text.text.length > 2)
        {
            en_text.text = ''
            fa_text.text = ''
            lsview.forceActiveFocus()
        }
        else
        {
            if( pc_mode )
            {
                if ( pc_view.indexAt(10,pc_view.contentY)+1 < num )
                {
                    pc_view.contentY = 1;
                }
                else
                {
                    //pc_view.contentY = pc_view.contentY - num*(root.height * 0.125);

                    console.log(main_view.getLsConY())
                    pc_view.positionViewAtIndex(main_view.getLsConY() - num - 1, ListView.Beginning)
                }
            }
            else
            {
                if ( lsview.indexAt(10,lsview.contentY)+1 < num )
                {
                    lsview.contentY = 1;
                }
                else
                {
                    lsview.contentY = lsview.contentY - num*(root.height * 0.125);
                }
            }
        }
    }

    function fastScrollDown(num)
    {
        if( pc_mode )
        {
            if (pc_view.indexAt(10,pc_view.contentY)+num > pc_view.count)
            {
                pc_view.positionViewAtEnd()
            }
            else
            {
               //pc_view.contentY = pc_view.contentY + num * (root.height * 0.125)
               console.log(main_view.getLsConY(), num)
               pc_view.positionViewAtIndex(main_view.getLsConY() + num + 6, ListView.End)
            }
        }
        else
        {
            if (lsview.indexAt(10,lsview.contentY)+num > lsview.count)
                lsview.positionViewAtEnd()
            else
               lsview.contentY = lsview.contentY + num * (root.height * 0.125)
        }
    }
}


