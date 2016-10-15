#include <QGuiApplication>
#include <QQmlApplicationEngine>

void debugMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg);

int main(int argc, char *argv[])
{

#ifdef QT_NO_DEBUG
    qInstallMessageHandler(debugMessageHandler);
    FILE * pFile = fopen("console.log","w");
    fclose(pFile);
#endif

    QGuiApplication app(argc, argv);

    app.setOrganizationName("Far Eastern Federal University, HPC lab");
    app.setOrganizationDomain("tef-dvfu.ru");
    app.setApplicationName("simpleTimer");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

QString prevMsg;
void debugMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    FILE * pFile = fopen("console.log","a");
    if (msg==prevMsg){
        fprintf(pFile, "|");
    } else {
        prevMsg=msg;
        QByteArray localMsg = msg.toLocal8Bit();
        switch (type) {
        case QtDebugMsg:
            fprintf(pFile, "\nDebug: (%s:%u, %s) %s ", context.file, context.line, context.function, localMsg.constData());
            break;
        case QtInfoMsg:
            fprintf(pFile, "\nInfo: (%s:%u, %s) %s ", context.file, context.line, context.function, localMsg.constData());
            break;
        case QtWarningMsg:
            fprintf(pFile, "\nWarning: (%s:%u, %s) %s ", context.file, context.line, context.function, localMsg.constData());
            break;
        case QtCriticalMsg:
            fprintf(pFile, "\nCritical: (%s:%u, %s) %s ", context.file, context.line, context.function, localMsg.constData());
            break;
        case QtFatalMsg:
            fprintf(pFile, "\nFatal: (%s:%u, %s) %s ", context.file, context.line, context.function, localMsg.constData());
            abort();
        }
    }
    fclose(pFile);
}
