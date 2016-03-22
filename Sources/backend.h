#ifndef BACKEND_H
#define BACKEND_H

#include <gio/gio.h>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlProperty>
#include <QtDBus>

struct screen_pos{
    int x;
    int y;
};

struct assistant_options{
    bool strictLoad;
    int  timeout;
} ;


assistant_options loadOptions();

int getIntCommand(char *command);
QString getStrCommand(QString *command);

screen_pos getPrimaryScreen();

void updateScreenInfo(QObject *item);
void startTranslate(QObject *item, QString word);
void showNotif(QObject *item);

QString getTranslate(QString word);
QString getDiscovedWord(QString word);
QString getTranslateStrict(QString word);
QString getTranslateOnline(QString word);

#endif // BACKEND_H
