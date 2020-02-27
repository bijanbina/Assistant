#include "highlight.h"

Highlight::Highlight(int is_pc)
{
    pc_mode = is_pc;
    highlight_words = QVector<QString> (6000);
    char buffer[6000];
    for (int i = 0 ; i<6000 ; i++)
    {
        buffer[i] = 'f';
    }
    buffer[5999] = '\0';
    highlight_string = buffer;

    if( is_pc )
    {
        highlight_file = new QFile("/home/bijan/Project/Assistant/Resources/phrasebook_hl");
    }
    else
    {
        highlight_file = new QFile("/storage/emulated/0/BIC/phrasebook_hl");
    }

    //QFile inputFile(":/phrasebook");
    int i =0;
    if (highlight_file->open(QIODevice::ReadWrite))
    {
       QTextStream in(highlight_file);
       while (!in.atEnd())
       {
          highlight_words[i] = in.readLine();
          i++;
       }
    }
    else
    {
        qDebug() << "cannot open highlight file";
    }
    cursor_i = 0;
    highlight_size = i;
}

Highlight::~Highlight()
{
    highlight_file->close();
}

bool Highlight::isHighlight(QString word, int id)
{
    if ( highlight_words[cursor_i] == word )
    {
        cursor_i++;
        highlight_string[id] = 't';
        return true;
    }
    for (int i = cursor_i; i < cursor_i + 50 ; i++)
    {
        if ( highlight_words[i] == word )
        {
            highlight_words.remove(cursor_i, i - cursor_i);
            cursor_i++;
            highlight_string[id] = 't';
            return true;
        }
    }
    return false;
}

void Highlight::removeHighlight(QString word)
{
    for (int i = 0; i < 6000 ; i++)
    {
        if ( highlight_words[i] == word )
        {
            highlight_words.removeAt(i);
            saveHighlight();
            return;
        }
        if ( highlight_words[i] == "" )
        {
            break;
        }
    }
}

void Highlight::addHighlight(QString word, QString last)
{
    if ( last == "" )
    {
        highlight_words.insert(0, word);
        highlight_size++;
        saveHighlight();
        return;
    }
    for (int i = highlight_size; 0 < i ; i--)
    {
        if ( highlight_words[i-1] == last )
        {
            highlight_words.insert(i, word);
            highlight_size++;
            saveHighlight();
            return;
        }
        /*if ( highlight_words[i] == "" )
        {
            break;
        }*/
    }
}

void Highlight::saveHighlight()
{
    QTextStream h_stream(highlight_file);
    highlight_file->resize(0);

    for (int i = 0; i < 6000 ; i++)
    {
        if ( highlight_words[i] != "" )
        {
            h_stream << highlight_words[i] << "\n" ;
        }
        else
        {
            break;
        }
    }
}

QString Highlight::getHighlightString()
{
    return highlight_string;
}
