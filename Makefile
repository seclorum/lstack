.POSIX:
CC      = cc
CFLAGS  = -std=c11 -Wall -Wextra -O3 -mcx16 -pthread
LDFLAGS = -pthread

PLATFORM := $(shell uname)

ifeq  ($(PLATFORM),Darwin)
LDLIBS  = -latomic_ops
else
LDLIBS  = -latomic
endif

objects = main.o lstack.o sha1.o

main: $(objects)
	$(CC) $(LDFLAGS) -o $@ $(objects) $(LDLIBS)

main.o: main.c lstack.h sha1.h
lstack.o: lstack.c lstack.h
sha1.o: sha1.c

run: main
	./main

clean:
	rm -f main $(objects)
