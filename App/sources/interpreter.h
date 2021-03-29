#ifndef INTERPRETER_H
#define INTERPRETER_H
#include <QFile>
#include <QDebug>
#include <QVector>
#include <QObject>
#include <QDir>
#include <QQmlProperty>

class GaInterpreter : public QObject
{
    Q_OBJECT

public:
    explicit GaInterpreter(QObject *ui, QObject *parent = NULL);
    ~GaInterpreter();

public slots:
    void keyPress(int key);

private:
    int command_count;
    int command;
    int isPronounce;
    QObject  *root;
};

#endif // INTERPRETER_H
