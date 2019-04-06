CHAINPREFIX=/opt/mipsel-linux-uclibc
CROSS_COMPILE=$(CHAINPREFIX)/usr/bin/mipsel-linux-

CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++
STRIP = $(CROSS_COMPILE)strip

SYSROOT     := $(CHAINPREFIX)/usr/mipsel-buildroot-linux-uclibc/sysroot
SDL_CFLAGS  := $(shell $(SYSROOT)/usr/bin/sdl-config --cflags)
SDL_LIBS    := $(shell $(SYSROOT)/usr/bin/sdl-config --libs)

TARGET = arkanoid.dge
OBJECTS = main.o anims.o sprites.o dust.o frame.o mst.o animspr.o fire.o menu.o preca.o breaker.o font.o monsters.o snd.o

CFLAGS += -O3 -Wall -g $(SDL_CFLAGS)
LIBS += $(SDL_LIBS) -lSDL -lSDL_image -lSDL_mixer

all: $(TARGET)

clean:
	rm *.o

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) 

