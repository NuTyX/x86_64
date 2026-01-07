# 1. edit you OS if you want....

OS=LINUX
#OS=FREEBSD
#OS=OPENBSD
#OS=NETBSD

# 2. edit dest dir prefix if you want....

PREFIX='/usr'

# 3. for programmers only: debugging in 64 bit Linux
DEBUG=false
#DEBUG=true

# 4. decide for nasm or yasm assembler (for 64 bit Linux version only)
NASM_OR_YASM=nasm
#NASM_OR_YASM=yasm

EXMODE=SED

#----------------------do not edit below line-------------------------------

BINDIR='$(PREFIX)/bin'
MANSEC='1'
MANDIR='$(PREFIX)/share/man/man$(MANSEC)'

ASOURCES=e3.asm e3.h
AFLAGS = -w+orphan-labels -f elf

ifeq	($(NASM_OR_YASM),nasm)
 ASSEMBLER64=nasm -O2 -g -w+orphan-labels -f elf64  -o e3.o e3.tmp -l e3nasm64.lst -DLINUX -DSED  -DAMD64
else
 ASSEMBLER64=yasm -g STABS -a x86 -m amd64 -f elf64 -p nasm -L nasm $(AFLAGS) -l e3yasm64.lst -o e3.o -DLINUX -DSED -DYASM -DAMD64 e3.tmp
endif

#---------------- default--------------------------
all:	32

#---------------- 32 bit LINUX (and perhaps BSD) --

32:	$(ASOURCES) Makefile
ifeq	($(OS),LINUX)
	nasm -O2 -f bin -l e3.lst -o e3 e3.asm -DCRIPLED_ELF=1 -D$(OS) -D$(EXMODE) 
	chmod +x e3
else
	echo $(ASVER)
	nasm -O2 $(AFLAGS) -o e3.o e3.asm -l e3.lst -D$(OS) -D$(EXMODE)
	ld -s -o e3 e3.o
	strip --remove-section .comment e3
endif
	ln -sf e3 e3ws
	ln -sf e3 e3em
	ln -sf e3 e3pi
	ln -sf e3 e3vi
	ln -sf e3 e3ne

# ------------- 64 bit L I N U X ------------------

64:	$(ASOURCES) Makefile
	cat e3.asm | sed -f e3_32to64.sed  >e3.tmp
	$(ASSEMBLER64)
	ld -b elf64-x86-64 --oformat elf64-x86-64 -o e3 e3.o
ifneq	($(DEBUG),true)
	strip e3
endif
	ln -sf e3 e3ws
	ln -sf e3 e3em
	ln -sf e3 e3pi
	ln -sf e3 e3vi
	ln -sf e3 e3ne

# -------------------------------------------------

install:	e3
	install -d $(BINDIR) $(MANDIR)
	install -m 755 e3 $(BINDIR)
	ln -sf e3 $(BINDIR)/e3ws
	ln -sf e3 $(BINDIR)/e3em
	ln -sf e3 $(BINDIR)/e3pi
	ln -sf e3 $(BINDIR)/e3vi
	ln -sf e3 $(BINDIR)/e3ne
	install -m 644 e3.man $(MANDIR)/e3.$(MANSEC)

clean:
	rm -f e3*.o e3*.lst e3.tmp e3 e3em e3pi e3vi e3ws e3ne *~
