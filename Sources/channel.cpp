#include "channel.h"

Channel::Channel(QObject *ui,QObject *parent) : QObject(parent)
{
    ConnectDBus();
    root = ui;
}


Channel::~Channel()
{
    ;
}

void Channel::ConnectDBus()
{
    QDBusConnection session = QDBusConnection::sessionBus();

    if (!session.isConnected())
    {
        qFatal("Cannot connect to the D-Bus session bus.");
        return;
    }

    session.connect("", "/", "com.binaee.assistant", "translate", this, SLOT(translate(const QString &)));

    if(!session.registerObject("/", this, QDBusConnection::ExportScriptableContents)) {
        qFatal("Cannot registerObject.");
        return;
    }

    if(!session.registerService("com.binaee.assistant")) {
        qFatal("Cannot registerObject.");
        return;
    }
}

void Channel::translate(const QString &text)
{
    QString word = text;
    qDebug() << "request received" << text;
    updateScreenInfo(root);
    startTranslate(root,word);
}
