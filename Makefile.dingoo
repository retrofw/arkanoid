# Mon Makefile
#PATH = /usr/include/SDL
TARGET = Arkanoid
OBJECTS = main.o anims.o sprites.o dust.o frame.o mst.o animspr.o fire.o menu.o preca.o breaker.o font.o monsters.o snd.o

CFLAGS = -O3 -Wall -g -I/opt/dingoo-uclibc-toolchain-06-17/usr/include/SDL -L/opt/mipsel-linux-uclibc/lib 
LIBS = -lSDL
LIBS = -lSDL -lSDL_image -lSDL_mixer
CC = mipsel-linux-gcc

all: $(TARGET)

clean:
	rm *.o

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) 

