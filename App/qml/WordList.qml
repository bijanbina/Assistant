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
    ListView
    {
        id: lsview
        anchors.fill: parent
        headerPositioning: ListView.PullBackHeader
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
         //focus: true

         onContentYChanged: updatePage()
         //onContentHeightChanged: {lsview.contentY = (settings.ls_cony)*100.0}
         onWidthChanged: {
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

        delegate: BlackButtonBackground
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
        list_backup.append({"index_i" : index , "word" : word, "translate" : translate});
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

    function removeList() {
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

    function restoreList() {
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
        if (!star_mode) //no change color in starmode
        {
            //toggle color on ui
            if ( list_el.get(ind-1).highlight == 1)
            {
                list_el.get(ind-1).highlight = 0
            }
            else
            {
                list_el.get(ind-1).highlight = 1
            }

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
                    add_highlight(list_el.get(ind-1).word, "")
                }
                else
                {
                    add_highlight(list_el.get(ind-1).word, list_el.get(last_ind).word)
                }
            }
            else
            {
                highlight_string = highlight_string.substr(0, ind-1) + 'f' + highlight_string.substr(ind);
                remove_highlight(list_el.get(ind-1).word)
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

    function sayWord(ind)
    {
        //list_el.get(ind-1).sColor = "#2aba89"
        if(pc_mode)
        {
            playMusic.source = "file:///home/bijan/Project/Assistant/Scripts/MP3/" + list_el.get(ind-1).word + ".mp3"
        }
        else
        {
            playMusic.source = "file:///storage/emulated/0/BIC/MP3/" + list_el.get(ind-1).word + ".mp3"
        }
        playMusic.play()
        index_m = ind;
    }

    function sayWord_search(ind)
    {
        //list_el.get(ind-1).sColor = "#2aba89"
        if(pc_mode)
        {
            playMusic.source = "file:///home/bijan/Project/Assistant/Scripts/MP3/" + list_search.get(ind-1).word + ".mp3"
        }
        else
        {
            playMusic.source = "file:///storage/emulated/0/BIC/MP3/" + list_search.get(ind-1).word + ".mp3"
        }

        playMusic.play()
        index_m = ind;
    }

    function forceView(ind)
    {
        //lsview.positionViewAtIndex(ind, ListView.Center)
        lsview.positionViewAtIndex(ind - 1, ListView.Beginning)
    }

    function getLsConY()
    {
        return lsview.indexAt(10,lsview.contentY) + 1;
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

    function pronStoppedSearch(index)
    {
        list_search.get(index-1).sColor = "#bbb"
    }

    signal remove_highlight(string word)
    signal add_highlight(string word, string last)
}


