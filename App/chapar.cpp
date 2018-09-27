#include "chapar.h"
#include <QFile>

chapar::chapar(QObject *ui, QObject *parent) : QObject(parent)
{
    root = ui;
    buffer = "";
    IE = true;
    multiPacket = false;
    txBuffer = "";
}

void chapar::start()
{
    getAgentID();
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
    QFile inputFile("/storage/emulated/0/BIC/phrasebook");
    //QFile inputFile("/home/bijan/Project/gallery/phrasebook");
    //QFile inputFile(":/phrasebook");
    int i =0;
    if (inputFile.open(QIODevice::ReadOnly))
    {
       QTextStream in(&inputFile);
       while (!in.atEnd())
       {
          i++;
          QString line = in.readLine();
          int word2 = line.indexOf(",");
          QQmlProperty::write(root, "word1", line.mid(0,word2));
          QQmlProperty::write(root, "word2", line.mid(word2+2));
          QQmlProperty::write(root, "index_val", i);
          QMetaObject::invokeMethod(root, "addList");
       }
       inputFile.close();
       QMetaObject::invokeMethod(root, "itemAdded");

    }
}

void chapar::getAgentID()
{
    ;
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
