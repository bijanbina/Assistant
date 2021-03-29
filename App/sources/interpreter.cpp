#include "interpreter.h"

GaInterpreter::GaInterpreter(QObject *ui, QObject *parent) : QObject(parent)
{
    root = ui;
    command = 0;
    isPronounce = 0;
    command_count = 0;

    QObject::connect(root, SIGNAL(key_detect(int)), this, SLOT(keyPress(int)));
}

GaInterpreter::~GaInterpreter()
{

}

void GaInterpreter::keyPress(int key)
{
    command_count++;
    if ( command_count>2 )
    {
        command_count = 1;
        command = 0;
        isPronounce = 0;
    }

    if ( command_count==1 )
    {
        if( key==Qt::Key_A )
        {
            isPronounce = 1;
            command = 0;
        }
        else if( key==Qt::Key_B )
        {
            isPronounce = 1;
            command = 4;
        }
        else if( key==Qt::Key_C )
        {
            isPronounce = 1;
            command = 8;
        }
        else if( key==Qt::Key_D )
        {
            isPronounce = 1;
            command = 12;
        }
        else if( key==Qt::Key_E )
        {
            isPronounce = 1;
            command = 16;
        }
        else if( key==Qt::Key_F )
        {
            isPronounce = 1;
            command = 20;
        }
        else if( key==Qt::Key_G )
        {
            isPronounce = 1;
            command = 24;
        }
        else if( key==Qt::Key_1 )
        {
            isPronounce = 0;
            command = 0;
        }
        else if( key==Qt::Key_2 )
        {
            isPronounce = 0;
            command = 4;
        }
        else if( key==Qt::Key_3 )
        {
            isPronounce = 0;
            command = 8;
        }
        else if( key==Qt::Key_4 )
        {
            isPronounce = 0;
            command = 12;
        }
        else if( key==Qt::Key_5 )
        {
            isPronounce = 0;
            command = 16;
        }
        else if( key==Qt::Key_6 )
        {
            isPronounce = 0;
            command = 20;
        }
        else if( key==Qt::Key_7 )
        {
            isPronounce = 0;
            command = 24;
        }
        else
        {
            command = 0;
            isPronounce = 0;
            command_count = 0;
            return;
        }
    }
    else
    {
        if( key==Qt::Key_1 )
        {
            command += 1;

        }
        else if( key==Qt::Key_2 )
        {
            command += 2;

        }
        else if( key==Qt::Key_3 )
        {
            command += 3;
        }
        else if( key==Qt::Key_4 )
        {
            command += 4;
        }
        else if( key==Qt::Key_5 )
        {
            command += 5;
        }
        else
        {
            command = 0;
            isPronounce = 0;
            command_count = 0;
            return;
        }
    }

    if ( command_count==2 )
    {
        //qDebug() << "isPronounce:" << isPronounce << "command:" << command;

        if ( isPronounce )
        {
            QQmlProperty::write(root, "index_val", command);
            QMetaObject::invokeMethod(root, "highlightWord");
        }
        else
        {
            QQmlProperty::write(root, "index_val", command);
            QMetaObject::invokeMethod(root, "pronounceWord");
        }
    }
}
