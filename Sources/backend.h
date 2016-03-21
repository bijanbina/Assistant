#ifndef BACKEND_H
#define BACKEND_H

#include <libnotify/notify.h>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlProperty>

struct screen_pos{
    int x;
    int y;
};

int getIntCommand(char *command);
QString getStrCommand(QString *command);

screen_pos getPrimaryScreen();

void updateScreenInfo(QObject *item);
void startTranslate(QObject *item);

QString getTranslate(QString word);
QString getTranslateOnline(QString word);

#endif // BACKEND_H
