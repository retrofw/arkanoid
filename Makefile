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

ipk: $(TARGET)
	@rm -rf /tmp/.arkanoid-ipk/ && mkdir -p /tmp/.arkanoid-ipk/root/home/retrofw/games/arkanoid /tmp/.arkanoid-ipk/root/home/retrofw/apps/gmenu2x/sections/games
	@cp -r arkanoid/arkanoid.dge arkanoid/arkanoid.png arkanoid/gfx arkanoid/snd /tmp/.arkanoid-ipk/root/home/retrofw/games/arkanoid
	@cp arkanoid/arkanoid.lnk /tmp/.arkanoid-ipk/root/home/retrofw/apps/gmenu2x/sections/games
	@sed "s/^Version:.*/Version: $$(date +%Y%m%d)/" arkanoid/control > /tmp/.arkanoid-ipk/control
	@cp arkanoid/conffiles /tmp/.arkanoid-ipk/
	@tar --owner=0 --group=0 -czvf /tmp/.arkanoid-ipk/control.tar.gz -C /tmp/.arkanoid-ipk/ control conffiles
	@tar --owner=0 --group=0 -czvf /tmp/.arkanoid-ipk/data.tar.gz -C /tmp/.arkanoid-ipk/root/ .
	@echo 2.0 > /tmp/.arkanoid-ipk/debian-binary
	@ar r arkanoid/arkanoid.ipk /tmp/.arkanoid-ipk/control.tar.gz /tmp/.arkanoid-ipk/data.tar.gz /tmp/.arkanoid-ipk/debian-binary

clean:
	rm src/*.o $(TARGET) arkanoid/arkanoid.ipk

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) 

