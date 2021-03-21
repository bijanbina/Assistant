#ifndef HIGHLIGHT_H
#define HIGHLIGHT_H
#include <QFile>
#include <QDebug>
#include <QVector>
#include <QDir>

class Highlight
{
public:
    Highlight(int is_pc);
    ~Highlight();
    bool isHighlight(QString word, int id);
    void removeHighlight(QString word);
    void addHighlight(QString word, QString last);
    void saveHighlight();
    QString getHighlightString();
    int pc_mode = 0;

private:
    QString highlight_string;
    QFile *highlight_file;
    QVector<QString> highlight_words;
    int cursor_i;
    int highlight_size;
};

#endif // HIGHLIGHT_H
