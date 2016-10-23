#include "backend.h"

assistant_options option;

int runCommand(char *command)
{
//
}

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

    returnData.remove('\n');

    /* close */
    pclose(fp);
    return returnData;
}

//This function use a seprated thread
QString get_translation_thread(QString command)
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

    returnData.remove('\n');

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
}

void loadOptions()
{
    GSettings *setting;
    setting = g_settings_new (ORG_NAME);
    option.strictLoad = g_settings_get_boolean (setting,"restrict-search");
    option.timeout = g_settings_get_int(setting,"timeout");
    qDebug() << "restrict-search is " << option.strictLoad;
    qDebug() << "timeout is " << option.timeout;
}

QString getTranslateStrict(QString word)
{
    QString command = "grep -i -w \"";
    command.append(word);
    command.append(" \" ");
    command.append(ASSISTANT_PATH"Scripts/phrasebook");
    command.append(" | awk -F \" , \" '{print $2}'");
    QString translate = getStrCommand(command);
    command = "grep -i -w \"";
    command.append(word);
    command.append(" \" ");
    command.append(ASSISTANT_PATH"Scripts/phrasebook");
    command.append(" | awk -F \" , \" '{print $1}'");
    if (word == getStrCommand(command))
    {
        return translate;// constrain
    }
    else
    {
        return "";
    }
}

QString getTranslate(QString word)
{
    QString translate;

    //find statement end with `word`
    QString command = "grep -i \"";
    command.append(word);
    command.append(" \" ");
    command.append(ASSISTANT_PATH"Scripts/phrasebook");
    command.append(" | awk -F \" , \" '{print $2}'");
    translate = getStrCommand(command);
    if (!translate.isEmpty())
        return translate;

    //find `word` in any place statement
    command = "grep -i \"";
    command.append(word);
    command.append("\" ");
    command.append(ASSISTANT_PATH"Scripts/phrasebook");
    command.append(" | awk -F \" , \" '{print $2}'");
    return getStrCommand(command);
}

void askWord(QObject *item)
{
    QString context, title;

    option.currentLanguage = getIntCommand(ASSISTANT_PATH"Scripts/getLanguage");
    getIntCommand("setxkbmap -option grp:alt_shift_toggle us,ir");

    title = "Translate";
    context = "Enter your word";
    QMetaObject::invokeMethod(item, "inputForm"); //show warning to
    QQmlProperty::write(item, "title", title);
    QQmlProperty::write(item, "context", context);
    QQmlProperty::write(item, "timeout", 100000 );
}

QString getDiscovedWord(QString word)
{
    QString translate;

    //find statement end with `word`
    QString command = "grep -i \"";
    command.append(word);
    command.append(" \" ");
    command.append(ASSISTANT_PATH"Scripts/phrasebook");
    command.append(" | awk -F \" , \" '{print $1}'");
    translate = getStrCommand(command);
    if (!translate.isEmpty())
        return translate;

    //find `word` in any place statement
    command = "grep -i \"";
    command.append(word);
    command.append("\" ");
    command.append(ASSISTANT_PATH"Scripts/phrasebook");
    command.append(" | awk -F \" , \" '{print $1}'");
    return getStrCommand(command);
}

QString getTranslateOnline(QString word)
{
    QString command = "wget -T 5 -U \"Mozilla/5.0\" -qO - \"http://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=fa&dt=t&q=";
    command.append(word);
    command.append(" \" | sed  -e \"s:\\[.*\\[::g\" -e \"s:].*]::g\" -e \"s:\\\"::g\"  | awk -F',' '{print $1}'");
    qDebug() << "hi";
    return getStrCommand(command);// constrain
}

void showNotif(QObject *item)
{
    QMetaObject::invokeMethod(item, "showNotif");
}

QString addPhraseBook(QString word, QString translate)
{
    changeLaguageBack();
    QString command = ASSISTANT_PATH"Scripts/ph_add.sh";
    command.append(" \"");
    command.append(word);
    command.append("\"");
    command.append(" \"");
    command.append(translate);
    command.append("\"");
    return getStrCommand(command);// constrain
}

void changeLaguageBack()
{
    if ( option.currentLanguage == 0 )
    {
        getIntCommand("setxkbmap -option grp:alt_shift_toggle us,ir");
    }
    else
    {
        getIntCommand("setxkbmap -option grp:alt_shift_toggle us,ir");
    }
}
