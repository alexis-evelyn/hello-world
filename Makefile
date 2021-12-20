# Assembly
ASM=nasm
LD=ld

# C
CC=gcc
CFLAGS=


all: assembly c


# Assembly
assembly: asm64 partclean
asm: asm32 asm64 partclean
asm32:
	$(ASM) -f elf32 hello.asm -o hello.32.o
	$(LD) -m elf_i386 -o hello.asm.32.elf hello.32.o

asm64:
	$(ASM) -f elf64 hello.asm -o hello.64.o
	$(LD) -m elf_x86_64 -o hello.asm.64.elf hello.64.o


# C Code
c: cnative partclean
cmultiarch: cnative c32 c64 partclean
c32:
	$(CC) hello.c -o hello.c.32.elf -m32

c64:
	$(CC) hello.c -o hello.c.64.elf -m64

cnative:
	$(CC) hello.c -o hello.c.elf

# Cleaning
partclean:
	rm -f *.o

clean:
	rm -f *.elf *.o
