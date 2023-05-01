CONFIG += c++11 console
# консольное приложение
CONFIG -= app_bundle
DEFINES += QT_DEPRECATED_WARNINGS
SOURCES += main.cpp
QMAKE_EXTRA_COMPILERS += nasm
NASMEXTRAFLAGS = -f elf64 -g -F dwarf
OTHER_FILES += $$NASM_SOURCES
nasm.output = ${QMAKE_FILE_BASE}.o
nasm.commands = nasm $$NASMEXTRAFLAGS -o ${QMAKE_FILE_BASE}.o ${QMAKE_FILE_NAME}
nasm.input = NASM_SOURCES
NASM_SOURCES = text.asm

OBJECTS += text.o # подключение объектного модуля ассемблерной
# подпрограммы
DISTFILES += text.asm # включение в проект исходного модуля
# на ассемблере для удобства вызова его
# исходного текста в текстовый редактор
CONFIG ~= s/-O[0123s]//g # отключение оптимизации
CONFIG += -O0
