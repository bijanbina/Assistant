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

    session.connect("", "/", COM_NAME, "translate", this, SLOT(translate(const QString &)));
    session.connect("", "/", COM_NAME, "direct", this, SLOT(translateDirect()));

    if(!session.registerObject("/", this, QDBusConnection::ExportScriptableContents)) {
        qFatal("Another session is on DBus.");
        return;
    }

    if(!session.registerService(COM_NAME)) {
        qFatal("Another session is on DBus.");
        return;
    }
}

void Channel::translate(const QString &text)
{
    QString word = text;
    //qDebug() << "request received" << text;
    updateScreenInfo(root);
    showNotif(root);
    startTranslate(root,word);
}

void Channel::translateDirect()
{
    QString word = "Translate";
    //qDebug() << "request received" << text;
    updateScreenInfo(root);
    startTranslate(root,word);
}

void Channel::startServer()
{
    phChecker = new QTimer;
    QObject::connect(phChecker,SIGNAL(timeout()),this,SLOT(checkPhraseBook()));
    phChecker->start(3600000);
}

//check for phrasebook if its already outdated
void Channel::checkPhraseBook()
{
    QFileInfo *phInfo = new QFileInfo(ASSISTANT_PATH"Scripts/phrasebook");
    phChecker->start(3600000);
    QDateTime now = QDateTime::currentDateTime();
    if (now.toTime_t() - phInfo->created().toTime_t() > 28800)
    {
        qDebug() << "Upgrade Now Going";
        getIntCommand(ASSISTANT_PATH"Scripts/ph_download.sh");
    }
}

void Channel::writeAccepted(QString title, QString word)
{
    qDebug() << "writeAccepted";
    addPhraseBook(title, word);
    QMetaObject::invokeMethod(root, "hide");
}
