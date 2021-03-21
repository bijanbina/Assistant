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
    property real height_item_lsview: root.height * 0.125

    ListView
    {
        id: lsview
        anchors.fill: parent
        clip: true
        focus: focus_list && !root.pc_mode
        interactive: false
        visible: !pc_mode
        model: ListModel
        {
            id: list_el
        }

        delegate: WordButton
        {
            width: root.width
            height: height_item_lsview
            word_left: word
            word_right: translate
            word_index: index_i
            word_highlighted: highlight
            soundColor: sColor

            onMouseOnSound:
            {
                sColor = "#2aba89"
            }

            onClickedWord:
            {
                updateHighlight(indx, wordLeft, wordRight, highlight)
            }

         }

        Keys.onPressed:
        {
            if ( event.key===Qt.Key_Up )
            {
                fastScrollUp(5)
            }
            else if ( event.key===Qt.Key_Down )
            {
                fastScrollDown(5)
            }
            else if ( event.key===Qt.Key_Space )
            {
//                //console.log("move up");
//                if (lsview.contentY + 100 > (lsview.contentHeight-root.height))
//                    lsview.contentY = lsview.contentHeight - root.height;
//                else
//                   lsview.contentY = lsview.contentY + 100
//                event.accepted = true;
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
//        list_backup.append({"index_i" : index , "word" : word, "translate" : translate})
    }

    function en_search_show(text, isClear)
    {
        var i = 0;
        var rc = 0;
        var max_size = list_search.count;
        //remove all previous search
        for ( i = 0 ; i < max_size ; i=i+1 )
        {
            if (list_search.get(i-rc).word.indexOf(text) === -1 || isClear )
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
            if (list_search.get(i-rc).translate.indexOf(text) === -1 || isClear )
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
            if (highlight_string[i] === 'f' )
            {
                list_el.remove(i-rc);
                rc = rc + 1;
            }
            else if ( word1 === list_el.get(i-rc).word )
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

    //Chnage color of index
    function changecl(ind)
    {
//        var list_word
//        if( pc_mode )
//        {
//            if (!star_mode) //no change color in starmode
//            {
//                //toggle color on ui
//                if ( ind%4 == 1 )
//                {
//                    list_word = list_pc.get(ind/4).word1
//                    if ( list_pc.get(ind/4).highlight1 === 1)
//                    {
//                        list_pc.get(ind/4).highlight1 = 0
//                    }
//                    else
//                    {
//                        list_pc.get(ind/4).highlight1 = 1
//                    }
//                }
//                else if ( ind%4 == 2 )
//                {
//                    list_word = list_pc.get(ind/4).word2
//                    if ( list_pc.get(ind/4).highlight2 === 1)
//                    {
//                        list_pc.get(ind/4).highlight2 = 0
//                    }
//                    else
//                    {
//                        list_pc.get(ind/4).highlight2 = 1
//                    }
//                }
//                else if ( ind%4 == 3 )
//                {
//                    list_word = list_pc.get(ind/4).word3
//                    if ( list_pc.get(ind/4).highlight3 === 1)
//                    {
//                        list_pc.get(ind/4).highlight3 = 0
//                    }
//                    else
//                    {
//                        list_pc.get(ind/4).highlight3 = 1
//                    }
//                }
//                else if ( ind%4 == 4 )
//                {
//                    list_word = list_pc.get(ind/4).word4
//                    if ( list_pc.get(ind/4).highlight4 === 1)
//                    {
//                        list_pc.get(ind/4).highlight4 = 0
//                    }
//                    else
//                    {
//                        list_pc.get(ind/4).highlight4 = 1
//                    }
//                }


//            }
//            else //in star_mode
//            {
//                if ( list_el.get(ind-1).highlight == 2)
//                {
//                    list_el.get(ind-1).highlight = 1
//                }
//                else
//                {
//                    list_el.get(ind-1).highlight = 2
//                }
//            }
//        }
//        else
//        {
//            if (!star_mode) //no change color in starmode
//            {
//                list_word = list_el.get(ind-1).word

//                //toggle color on ui
//                if ( list_word.get(ind-1).highlight == 1)
//                {
//                    list_word.get(ind-1).highlight = 0
//                }
//                else
//                {
//                    list_el.get(ind-1).highlight = 1
//                }
//            }
//            else //in star_mode
//            {
//                if ( ind%4 == 1 )
//                {
//                    if ( list_pc.get(ind/4).highlight1 === 2)
//                    {
//                        list_pc.get(ind/4).highlight1 = 1
//                    }
//                    else
//                    {
//                        list_pc.get(ind/4).highlight1 = 2
//                    }
//                }
//                else if ( ind%4 == 2 )
//                {
//                    if ( list_pc.get(ind/4).highlight2 === 2)
//                    {
//                        list_pc.get(ind/4).highlight2 = 1
//                    }
//                    else
//                    {
//                        list_pc.get(ind/4).highlight2 = 2
//                    }
//                }
//                else if ( ind%4 == 3 )
//                {
//                    if ( list_pc.get(ind/4).highlight3 === 2)
//                    {
//                        list_pc.get(ind/4).highlight3 = 1
//                    }
//                    else
//                    {
//                        list_pc.get(ind/4).highlight3 = 2
//                    }
//                }
//                else if ( ind%4 == 4 )
//                {
//                    if ( list_pc.get(ind/4).highlight4 === 2)
//                    {
//                        list_pc.get(ind/4).highlight4 = 1
//                    }
//                    else
//                    {
//                        list_pc.get(ind/4).highlight4 = 2
//                    }
//                }
//            }
//        }

//        if (!star_mode) //no change color in starmode
//        {
//            //change setting (f char=false, t char = true)
//            if (highlight_string[ind-1] === 'f' )
//            {
//                highlight_string = highlight_string.substr(0, ind-1) + 't' + highlight_string.substr(ind);
//                var last_ind = ind-2
//                for ( ; last_ind > 0 ; last_ind-- )
//                {
//                    if (highlight_string[last_ind] !== 'f' )
//                    {
//                        break;
//                    }
//                }

//                if ( last_ind === 0 )
//                {
//                    add_highlight(list_word, "")
//                }
//                else
//                {
//                    var last_word
//                    if( pc_mode )
//                    {
//                        last_ind = last_ind + 1;

//                        if ( last_ind%4 == 1 )
//                        {
//                            last_word = list_pc.get(last_ind/4).word1;
//                        }
//                        else if ( last_ind%4 == 2 )
//                        {
//                            last_word = list_pc.get(last_ind/4).word2;
//                        }
//                        else if ( last_ind%4 == 3 )
//                        {
//                            last_word = list_pc.get(last_ind/4).word3;
//                        }
//                        else if ( last_ind%4 == 4 )
//                        {
//                            last_word = list_pc.get(last_ind/4).word4;
//                        }
//                    }
//                    else
//                    {
//                        last_word = list_el.get(last_ind).word;
//                    }

//                    add_highlight(list_word, last_word)
//                }
//            }
//            else
//            {
//                highlight_string = highlight_string.substr(0, ind-1) + 'f' + highlight_string.substr(ind);
//                remove_highlight(list_word)
//            }
//        }
    }

    function sayWord(ind)
    {
        index_m = ind;
    }

    function forceView(ind)
    {
        lsview.positionViewAtIndex(ind , ListView.Beginning)
    }

    function getLsConY()
    {
        return lsview.indexAt(10,lsview.contentY+height_item_lsview/2);
    }

    function getLsCount()
    {
        return list_el.count;
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
        list_el.get(index-1).sColor = "#bbb"
    }

    function pronError(index)
    {
        list_el.get(index-1).sColor = "#cd4646"
    }

    function pronStoppedSearch(index)
    {
        list_search.get(index-1).sColor = "#bbb"
    }

    function fastScrollUp(num)
    {
        var index_beginnig = getLsConY()
        if( index_beginnig < num)
        {
            lsview.positionViewAtBeginning()
        }
        else
        {
            lsview.positionViewAtIndex(index_beginnig - num, ListView.Beginning)
        }
    }

    function fastScrollDown(num)
    {
        var index_beginnig = getLsConY()
        var list_count = getLsCount()
        if( index_beginnig+num > list_count)
        {
            lsview.positionViewAtEnd()
        }
        else
        {
            lsview.positionViewAtIndex(index_beginnig + num, ListView.Beginning)
        }
    }

    function changeStarMode()
    {
        var index_value = getLsConY()

        var new_index = 0
        if (star_mode)
        {
            //4000 is max list index
            while (index_value < 4000)
            {
                if (highlight_string[index_value/*-1*/] === 't')
                {
                    break;
                }
                index_value = index_value + 1;
            }

            word1 = list_el.get(index_value/*-1*/).word
            new_index = removeList();
        }
        else
        {
            word1 = list_el.get(index_value/*-1*/).word
            new_index = restoreList();
        }
        updatePage()
        lsview.forceLayout()
        lsview.positionViewAtIndex(new_index - 1, ListView.Beginning)
    }

    function updateHighlight(indx, wordLeft, wordRight, highlight)
    {
        var item = list_el.get(indx-1)
        if(root.star_mode)
        {
            if(item.highlight===1)
            {
                item.highlight = 2
            }
            else
            {
                item.highlight = 1
            }
        }
        else
        {
            if(item.highlight===1)
            {
                item.highlight = 0
            }
            else if(item.highlight===0)
            {
                item.highlight = 1
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
                last_word = list_el.get(last_ind).word;
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


