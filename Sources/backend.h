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

screen_pos getPrimaryScreen();

void updateScreenInfo(QObject *item);

#endif // BACKEND_H
