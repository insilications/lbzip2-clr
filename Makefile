# Makefile,v 1.9 2009/04/03 22:33:49 lacos Exp
.POSIX:

CC=gcc
CFLAGS=$$($(SHELL) lfs.sh CFLAGS) -D _XOPEN_SOURCE=500 -pipe -ansi -pedantic \
    -O2




LDFLAGS=-s $$($(SHELL) lfs.sh LDFLAGS)
LIBS=-l pthread $$($(SHELL) lfs.sh LIBS)

OBJECTS=main.o lbzip2.o lbunzip2.o lacos_rbtree.o yambi/blocksort.o \
    yambi/collect.o yambi/crctab.o yambi/decode.o yambi/emit.o \
    yambi/encode.o yambi/prefix.o yambi/retrieve.o yambi/transmit.o

lbzip2: $(OBJECTS)
	$(CC) -o lbzip2 $(LDFLAGS) $(OBJECTS) $(LIBS)

main.o: main.c main.h lbunzip2.h lbzip2.h
	$(CC) $(CFLAGS) -c main.c

lbzip2.o: lbzip2.c yambi/yambi.h main.h lbzip2.h lacos_rbtree.h
	$(CC) $(CFLAGS) -c lbzip2.c

lbunzip2.o: lbunzip2.c yambi/yambi.h main.h lbunzip2.h lacos_rbtree.h
	$(CC) $(CFLAGS) -c lbunzip2.c

lacos_rbtree.o: lacos_rbtree.c lacos_rbtree.h
	$(CC) $(CFLAGS) -c lacos_rbtree.c

yambi/blocksort.o: yambi/blocksort.c yambi/encode.h yambi/private.h \
    yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/blocksort.c

yambi/collect.o: yambi/collect.c yambi/encode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/collect.c

yambi/crctab.o: yambi/crctab.c yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/crctab.c

yambi/decode.o: yambi/decode.c yambi/decode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/decode.c

yambi/emit.o: yambi/emit.c yambi/decode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/emit.c

yambi/encode.o: yambi/encode.c yambi/encode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/encode.c

yambi/prefix.o: yambi/prefix.c yambi/encode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/prefix.c

yambi/retrieve.o: yambi/retrieve.c yambi/decode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/retrieve.c

yambi/transmit.o: yambi/transmit.c yambi/encode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/transmit.c

clean:
	rm -f lbzip2 $(OBJECTS)

check:
	$(SHELL) test.sh $(TESTFILE)