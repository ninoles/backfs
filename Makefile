PREFIX=/usr/local

VERSION=BackFS v0.4pre\
$(shell test -d .git && echo "\ngit revision" && git log --pretty="format:%h %ai" -n1)\
\nbuilt $(shell date "+%Y-%m-%d %H:%M:%S %z")\n

DEFINES=-D_FILE_OFFSET_BITS=64 \
	-DFUSE_USE_VERSION=28 \
	-D_POSIX_C_SOURCE=201201 \
	-D_GNU_SOURCE \
	-DBACKFS_VERSION="\"$(VERSION)\"" \

BRANCH=$(shell test -d .git && (git branch | grep '^*' | cut -c3-) || echo "unknown")

ifeq ($(BRANCH),rw)
	DEFINES+= -DBACKFS_RW
endif

CFLAGS=-std=c1x -pedantic -g3 $(DEFINES) -I/usr/include/fuse
LDFLAGS=-lfuse

CC = gcc

OBJS = backfs.o fscache.o fsll.o util.o

all: backfs

.SUFFIXES:

%.o: %.c
	@echo "    CC  $<"
	@$(CC) $(CFLAGS) -c -o $@ $<

backfs: $(OBJS)
	@echo "  LINK  $<"
	@$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS)
	@echo "Built BackFS for branch: $(BRANCH)" 

clean:
	@echo " CLEAN"
	@rm -f *.o *~ backfs

install: backfs
	echo cp backfs $(PREFIX)/bin
	echo chmod 0755 $(PREFIX)/bin/backfs

# vim: noet sts=8 ts=8 sw=8
