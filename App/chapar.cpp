#include "chapar.h"

int getIntCommand(const char *command)
{
    FILE *fp;
    int returnData;

    char path[1035];

    /* Open the command for reading. */
    fp = popen(command, "r");

    if (fp == NULL) {
      printf("Failed to run command\n" );
      return -1;
    }

    /* Read the output a line at a time - output it. */
    while (fgets(path, sizeof(path)-1, fp) != NULL) {
      returnData = atoi(path);
    }

    /* close */
    pclose(fp);
    return returnData;
}

chapar::chapar(QObject *ui, QObject *parent) : QObject(parent)
{
    root = ui;
    buffer = "";
    IE = true;
    multiPacket = false;
    txBuffer = "";
    int pc_mode = QQmlProperty::read(root, "pc_mode").toInt();
    highlight_db = new Highlight(pc_mode);
}

void chapar::start()
{
    //getAgentID();
    //channel->write("12\n");
    //timout_reach();
}


void chapar::sendMSG(QString text)
{
    qDebug() << "Received FROM UI: " << text.toStdString().data();
    //send request
    ;
}

void chapar::updateData()
{
    //qDebug() <<"start index:" << start_index << "end index" << end_index;
    //qDebug() <<"buffer:" << buffer;
    QFile inputFile;
    if( highlight_db->pc_mode )
    {
        inputFile.setFileName("/home/bijan/Project/Assistant/Scripts/phrasebook");
    }
    else
    {
        inputFile.setFileName("/storage/emulated/0/BIC/phrasebook");
    }
    //QFile inputFile(":/phrasebook");
    int i =0;
    if (inputFile.open(QIODevice::ReadOnly))
    {
       QTextStream in(&inputFile);
       while (!in.atEnd())
       {
          i++;
          QString line = in.readLine();
          int word_sep = line.indexOf(",");
          QString word1 = line.mid(0,word_sep-1);
          QString word2 = line.mid(word_sep+2);
          bool isHighlight = highlight_db->isHighlight(word1 , i-1);
          QQmlProperty::write(root, "word1", word1);
          QQmlProperty::write(root, "word2", word2);
          QQmlProperty::write(root, "index_val", i);
          QQmlProperty::write(root, "isHighlight", isHighlight);
          QMetaObject::invokeMethod(root, "addList");
          //
          /*if (i < 5000)
          {
              QString command = QString("/home/bijan/Project/Assistant/Scripts/MP3/pr_download.sh ");
              command += line.mid(0,word2-1);
              getIntCommand(command.toStdString().c_str());
          }*/
       }
       inputFile.close();
       QString highlight_string = highlight_db->getHighlightString();
       QQmlProperty::write(root, "highlight_string", highlight_string);
       QMetaObject::invokeMethod(root, "itemAdded");
       highlight_db->saveHighlight();

    }
}

void chapar::removeHighlight(QString word)
{
    highlight_db->removeHighlight(word);
}

void chapar::addHighlight(QString word, QString last)
{
    highlight_db->addHighlight(word, last);
}

chapar::~chapar()
{
    ;
}



void chapar::sendMessage(QString message)
{
    //send request
    ;

}
