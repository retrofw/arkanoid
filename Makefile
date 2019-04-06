CHAINPREFIX=/opt/mipsel-linux-uclibc
CROSS_COMPILE=$(CHAINPREFIX)/usr/bin/mipsel-linux-

CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++
STRIP = $(CROSS_COMPILE)strip

SYSROOT     := $(CHAINPREFIX)/usr/mipsel-buildroot-linux-uclibc/sysroot
SDL_CFLAGS  := $(shell $(SYSROOT)/usr/bin/sdl-config --cflags)
SDL_LIBS    := $(shell $(SYSROOT)/usr/bin/sdl-config --libs)

TARGET = arkanoid/arkanoid.dge
OBJECTS = src/main.o src/anims.o src/sprites.o src/dust.o src/frame.o src/mst.o src/animspr.o src/fire.o src/menu.o src/preca.o src/breaker.o src/font.o src/monsters.o src/snd.o

CFLAGS += -O3 -Wall -g $(SDL_CFLAGS)
LIBS += $(SDL_LIBS) -lSDL -lSDL_image -lSDL_mixer

all: $(TARGET)

clean:
	rm src/*.o

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) 

