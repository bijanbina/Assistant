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

    /*if(!session.registerObject("/", this, QDBusConnection::ExportScriptableContents)) {
        qFatal("Another session is on DBus.");
        return;
    }*/

    if(!session.registerService(COM_NAME)) {
        qFatal("Another session is on DBus.");
        // This cannot be automatic because killing assistant also kill
        // this instant too
        return;
    }
}

void Channel::translate(const QString &text)
{
    QString word = text;

    isDirectLoad = false;

    //qDebug() << "request received" << text;
    updateScreenInfo(root);
    startTranslate(root,word);
    showNotif(root);
}

void Channel::translateDirect()
{
    isDirectLoad = true;

    updateScreenInfo(root);
    askWord(root);
    showNotif(root);
}

void Channel::startServer()
{
    //set time
    phChecker = new QTimer;
    QObject::connect(phChecker,SIGNAL(timeout()),this,SLOT(checkPhraseBook()));

    //check PH and start Timer
    checkPhraseBook();
}

//check for phrasebook if its already outdated
void Channel::checkPhraseBook()
{
    QFileInfo *phInfo = new QFileInfo(ASSISTANT_PATH"Scripts/phrasebook");
    phChecker->start(PH_UPDATE_INTERVAL * 60 * 1000);
    QDateTime now = QDateTime::currentDateTime();
    if (now.toTime_t() - phInfo->created().toTime_t() > PH_UPDATE_OUTDATED * 3600)
    {
        qDebug() << "Upgrade Now Going";
        getIntCommand(ASSISTANT_PATH"Scripts/ph_download.sh");
    }
}

void Channel::writeAccepted(QString title, QString word)
{
    if ( isDirectLoad )
    {
        translate(word);
    }
    else
    {
        QMetaObject::invokeMethod(root, "hide");
        qDebug() << "writeAccepted";
        addPhraseBook(title, word);
    }
}

void Channel::notifExit()
{
    changeLaguageBack();
}
