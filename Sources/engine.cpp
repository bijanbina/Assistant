#include "backend.h"
#include "engine.h"
#include <QDebug>
// This class use to run non blocking shell commmand
// Which is run on other thread

Engine::Engine(QString text)
{
    word = text;
}

void Engine::run()
{
    qDebug() << "request received";
    translate = getTranslateOnline(word);
}
