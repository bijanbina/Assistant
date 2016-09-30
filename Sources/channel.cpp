#include "channel.h"
#include <unistd.h>


Channel::Channel(QObject *ui,QObject *parent) : QObject(parent)
{
    ConnectDBus();
    root = ui;

    GSettings *setting;
    setting = g_settings_new (ORG_NAME);
    option.strictLoad = g_settings_get_boolean (setting,"restrict-search");
    option.timeout = g_settings_get_int(setting,"timeout");
    qDebug() << "restrict-search is " << option.strictLoad;
    qDebug() << "timeout is " << option.timeout;
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
    option.currentLanguage = getIntCommand(ASSISTANT_PATH"Scripts/getLanguage");
    updateScreenInfo(root);
    QString formMethod = "normalForm";
    QString translate;

    isDirectLoad = false;

    translate = getTranslateStrict(word);
    if (translate.isEmpty() && !(option.strictLoad))
    {
        translate = getTranslate(word);
        if (!translate.isEmpty())
            word = getDiscovedWord(word);
    }
    QMetaObject::invokeMethod(root, formMethod.toStdString().c_str()); //show warning to
    QQmlProperty::write(root, "title", word);
    QQmlProperty::write(root, "timeout", option.timeout );
    QQmlProperty::write(root, "context", "");
    if (translate.isEmpty()) //lets get online
    {
        translateEngine = new Engine(word);
        translateEngine->start();
        connect(translateEngine,SIGNAL(finished()),this,SLOT(translateOnlineReady()));
        formMethod = "expandForm";
        getIntCommand("setxkbmap ir");
    }
    else
    {
        QQmlProperty::write(root, "context", translate);
    }
    showNotif(root);

}

void Channel::translateDirect()
{
    isDirectLoad = true;

    updateScreenInfo(root);
    askWord(root);
    showNotif(root);
}

void Channel::translateOnlineReady()
{
    QQmlProperty::write(root, "context", translateEngine->translate);
    delete translateEngine;
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
        system(ASSISTANT_PATH"Scripts/ph_download.sh &");
    }
}

void Channel::writeAccepted(QString title, QString word)
{
    if ( isDirectLoad )//if input is from asking words
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
