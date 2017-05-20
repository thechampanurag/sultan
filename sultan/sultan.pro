include(../external_library/easyloggingpp/easyloggingpp/easyloggingpp.pri)
include(../libglobal/libglobal.pri)
include(../libdb/libdb.pri)
include(../libserver/libserver.pri)
include(../libgui/libgui.pri)

QT       += core gui widgets sql websockets

TARGET = Sultan
TEMPLATE = app

CONFIG += c++11

macx {
    QMAKE_LIBDIR += $$OUT_PWD/../bin/Sultan.app/Contents/Frameworks
    LIBS += -framework Foundation
    DESTDIR = ../bin
    copymigration_sqlite.commands = $$quote(cp -R $${PWD}/../migration_sqlite $$OUT_PWD/../bin/Sultan.app/Contents/Resources)
    copymigration_mysql.commands = $$quote(cp -R $${PWD}/../migration_mysql $$OUT_PWD/../bin/Sultan.app/Contents/Resources)
} else:win32 {
    LIBS += -L$$OUT_PWD/../bin
    RC_FILE = sultan.rc
    DESTDIR = ../bin/
    PWD_WIN = $${PWD}
    DESTDIR_WIN = $$OUT_PWD/../bin/
    PWD_WIN ~= s,/,\\,g
    DESTDIR_WIN ~= s,/,\\,g
    copymigration_sqlite.commands = $$quote(cmd /c xcopy /S /I /Y $${PWD_WIN}\..\migration_sqlite $${DESTDIR_WIN}\migration_sqlite)
    copymigration_mysql.commands = $$quote(cmd /c xcopy /S /I /Y $${PWD_WIN}\..\migration_mysql $${DESTDIR_WIN}\migration_mysql)
} else {
    QMAKE_LIBDIR = $$OUT_PWD/../bin $$QMAKE_LIBDIR
    LIBS += -L$$OUT_PWD/../bin
    DESTDIR = ../bin
    copymigration_sqlite.commands = $$quote(cp -R $${PWD}/../migration_sqlite $${OUT_PWD}/../bin/)
    copymigration_mysql.commands = $$quote(cp -R $${PWD}/../migration_mysql $${OUT_PWD}/../bin/)
}

QMAKE_EXTRA_TARGETS += copymigration_sqlite copymigration_mysql
POST_TARGETDEPS += copymigration_sqlite copymigration_mysql

RESOURCES += sultan.qrc

SOURCES += main.cpp \
    core.cpp \
    gui/splash.cpp \
    gui/settingdialog.cpp \
    socket/socketmanager.cpp \
    socket/socketclient.cpp \
    socket/sockethandler.cpp \
    gui/logindialog.cpp

HEADERS  += \
    core.h \
    gui/splash.h \
    gui/settingdialog.h \
    socket/socketmanager.h \
    socket/socketclient.h \
    socket/sockethandler.h \
    gui/logindialog.h

FORMS += \
    gui/splash.ui \
    gui/settingdialog.ui \
    gui/logindialog.ui