#include "backend.h"


int getIntCommand(char *command)
{
    FILE *fp;
    int returnData;

    char path[1035];

    /* Open the command for reading. */
    fp = popen(command, "r");

    if (fp == NULL) {
      printf("Failed to run command\n" );
      return -1;
    }

    /* Read the output a line at a time - output it. */
    while (fgets(path, sizeof(path)-1, fp) != NULL) {
      returnData = atoi(path);
    }

    /* close */
    pclose(fp);
    return returnData;
}

QString getStrCommand(QString command)
{
    FILE *fp;
    QString returnData;

    char path[1035];

    /* Open the command for reading. */
    fp = popen(command.toStdString().c_str(), "r");

    if (fp == NULL) {
      printf("Failed to run command\n" );
      return returnData;
    }

    /* Read the output a line at a time - output it. */
    while (fgets(path, sizeof(path)-1, fp) != NULL) {
      returnData = QString(path);
    }

    /* close */
    pclose(fp);
    return returnData;
}

screen_pos getPrimaryScreen()
{
    FILE *fp;
    screen_pos returnData;
    returnData.x = -1;
    returnData.y = -1;
    returnData.x = getIntCommand("xrandr --current | grep primary | awk '{print $4}' | awk -F '+' '{print $2}'");
    returnData.y = getIntCommand("xrandr --current | grep primary | awk '{print $4}' | awk -F '+' '{print $3}'");
    return returnData;
}

void updateScreenInfo(QObject *item)
{
    screen_pos PrimaryScreen = getPrimaryScreen();
    QQmlProperty::write(item, "x_base", PrimaryScreen.x);
    QQmlProperty::write(item, "y_base", PrimaryScreen.y);
    QQmlProperty::write(item, "visible", true);
    QMetaObject::invokeMethod(item, "startNotif");


}

void startTranslate(QObject *item,QString word)
{
    QString translate;
    translate = getTranslate(word);
    if (translate.isEmpty())
    {
        translate = getTranslateOnline(word);
        QMetaObject::invokeMethod(item, "expandNotif"); //show warning
    }
    QQmlProperty::write(item, "title", word);
    QQmlProperty::write(item, "context", translate);
}

QString getTranslate(QString word)
{
    QString command = "grep \"";
    command.append(word);
    command.append(" \" /home/bijan/Project/Assistant/Scripts/phrasebook | awk -F \" , \" '{print $2}'");
    return getStrCommand(command);// constrain
}

QString getTranslateOnline(QString word)
{
    QString command = "wget -U \"Mozilla/5.0\" -qO - \"http://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=fa&dt=t&q=";
    command.append(word);
    command.append(" \" | sed  -e \"s:\\[.*\\[::g\" -e \"s:].*]::g\" -e \"s:\\\"::g\"  | awk -F',' '{print $1}'");
    return getStrCommand(command);// constrain
}
