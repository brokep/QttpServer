QT -= gui core network

TEMPLATE = lib
CONFIG += staticlib
TARGET = http_parser

!win32 {
    VERSION = 2.7.1
}

include($$PWD/http_parser_qmake.pri)

CONFIG(debug, debug|release) {
    win32 {
        DESTDIR = $$PWD/../../build/Debug/lib
    } else {
        DESTDIR = $$PWD/../../build/out/Debug
    }
} else {
    win32 {
        DESTDIR = $$PWD/../../build/Release/lib
    } else {
        DESTDIR = $$PWD/../../build/out/Release
    }
}

mac: {
    LIBS += -framework CoreFoundation # -framework CoreServices
    QMAKE_CXXFLAGS += -g -O0 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -std=gnu++0x -stdlib=libc++
}

unix:!mac {
    # This supports GCC 4.7
    QMAKE_CXXFLAGS += -g -O0 -lm -lpthread -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -std=c++0x
}

win32 {
    QMAKE_CXXFLAGS += -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
    LIBS += \
        -llibuv \
        -lhttp_parser \
        -ladvapi32 \
        -liphlpapi \
        -lpsapi \
        -lshell32 \
        -lws2_32 \
        -luserenv \
        -luser32
}

INCLUDEPATH = $$unique(INCLUDEPATH)
HEADERS = $$unique(HEADERS)
SOURCES = $$unique(SOURCES)
