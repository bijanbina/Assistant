#ifndef BACKEND_H
#define BACKEND_H

#include <gio/gio.h>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlProperty>
#include <QtDBus>

#define COM_NAME "com.binaee.assistant"
#define ORG_NAME "org.binaee.assistant"
#define ASSISTANT_PATH "/home/bijan/Project/Assistant/"

struct screen_pos{
    int x;
    int y;
};

struct assistant_options{
    bool strictLoad;
    int  timeout;
    int  currentLanguage;
} ;


assistant_options loadOptions();

int getIntCommand(char *command);
QString getStrCommand(QString *command);

screen_pos getPrimaryScreen();
void changeLaguageBack();

void updateScreenInfo(QObject *item);
void startTranslate(QObject *item, QString word);
void showNotif(QObject *item);

QString getTranslate(QString word);
QString getDiscovedWord(QString word);
QString getTranslateStrict(QString word);
QString getTranslateOnline(QString word);
QString addPhraseBook(QString word, QString translate);


#endif // BACKEND_H
