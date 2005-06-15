#
# Root directory. Mainly useful for package building; leave empty for
# normal installation.
#
ROOT =

#
# The destination directory for the "sh" and "jsh" binaries.
#
SV3BIN=/usr/5bin

#
# A BSD-compatible install command.
#
UCBINST=/usr/ucb/install

#
# The strip command that is used at installation time.
#
STRIP=: strip -s -R .comment -R .note

#
# A command to create the link from "jsh" to "sh".
#
LNS=ln -s

#
# Uncomment the following line to compile with diet libc. -Ifakewchar might
# be usable for other environments without wide character support too.
#
#CC=diet gcc -Ifakewchar

#
# Compiler flags.
#
CFLAGS=-g -O

#
# Flags for the C preprocessor.
#
CPPFLAGS=-D_GNU_SOURCE

#
# The compiler warning options.
WERROR=-Werror
WARN = -Wchar-subscripts -Wformat -Wno-format-y2k -Wimplicit \
	-Wmissing-braces -Wsequence-point -Wreturn-type -Wtrigraphs \
	-Wunused-function -Wunused-label -Wunused-variable -Wunused-value \
	-Wuninitialized -Wmultichar -Wpointer-arith $(WERROR)
#WARN=

OBJ = args.o blok.o bltin.o cmd.o ctype.o defs.o echo.o error.o \
	expand.o fault.o func.o hash.o hashserv.o io.o jobs.o \
	macro.o main.o msg.o name.o print.o pwd.o service.o \
	setbrk.o stak.o string.o test.o ulimit.o word.o xec.o \
	gmatch.o getopt.o strsig.o version.o mapmalloc.o umask.o

.c.o: ; $(CC) -c $(CFLAGS) $(CPPFLAGS) $(WARN) $<

all: sh jsh

sh: $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ) $(LIBS) -o sh

jsh: sh
	rm -f jsh
	$(LNS) sh jsh

install: all
	test -d $(ROOT)$(SV3BIN) || mkdir -p $(ROOT)$(SV3BIN)
	$(UCBINST) -c -m 755 sh $(ROOT)$(SV3BIN)/sh
	$(STRIP) $(ROOT)$(SV3BIN)/sh
	rm -f $(ROOT)$(SV3BIN)/jsh
	cd $(ROOT)$(SV3BIN) && $(LNS) sh jsh

clean:
	rm -f $(OBJ) sh jsh core log *~

mrproper: clean

args.o: args.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
blok.o: blok.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
bltin.o: bltin.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h \
  sym.h hash.h
cmd.o: cmd.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h sym.h
ctype.o: ctype.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
defs.o: defs.c mode.h name.h
echo.o: echo.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
error.o: error.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
expand.o: expand.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
fault.o: fault.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
func.o: func.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
getopt.o: getopt.c
gmatch.o: gmatch.c mbtowi.h
hash.o: hash.c hash.h defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
hashserv.o: hashserv.c hash.h defs.h mac.h mode.h name.h stak.h brkincr.h \
  ctype.h
io.o: io.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h dup.h
jobs.o: jobs.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
macro.o: macro.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h \
  sym.h
main.o: main.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h sym.h \
  hash.h timeout.h dup.h
mapmalloc.o: mapmalloc.c
msg.o: msg.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h sym.h
name.o: name.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
print.o: print.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
pwd.o: pwd.c mac.h defs.h mode.h name.h stak.h brkincr.h ctype.h
service.o: service.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
setbrk.o: setbrk.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
stak.o: stak.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
string.o: string.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
strsig.o: strsig.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
test.o: test.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
ulimit.o: ulimit.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
umask.o: umask.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h
version.o: version.c
word.o: word.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h sym.h
xec.o: xec.c defs.h mac.h mode.h name.h stak.h brkincr.h ctype.h sym.h \
  hash.h
