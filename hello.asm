; ------------------------------------------------
; Hello World For Nasm Assembler
; For *nix Based Systems (Unix and Linux)
; Written For 32 Bit (Can Be Assembled For 64 Bit)
; ------------------------------------------------

; Modified From https://tldp.org/HOWTO/Assembly-HOWTO/hello.html
; Elf Format Explanation At https://wiki.osdev.org/ELF
; Also See https://gist.github.com/yellowbyte/d91da3c3b0bc3ee6d1d1ac5327b1b4b2
; Nasm Syntax At https://en.wikibooks.org/wiki/X86_Assembly/NASM_Syntax
; Register Info At https://wiki.osdev.org/CPU_Registers_x86-64
; More Register Info At https://www.tutorialspoint.com/assembly_programming/assembly_registers.htm
; System Calls At https://www.tutorialspoint.com/assembly_programming/assembly_system_calls.htm
; Instruction Explanation At https://www.cs.virginia.edu/~evans/cs216/guides/x86.html
; Page Of Executable Foramts At https://en.wikipedia.org/wiki/Comparison_of_executable_file_formats
; Info On Variables At https://stackoverflow.com/a/10168788/6828099
; Info On Numeric Constants At https://www.keil.com/support/man/docs/armasm/armasm_dom1361290008953.htm

; -----------------------
; Compile 32 Bit Elf File
; -----------------------
; nasm -f elf32 hello.asm
; ld -m elf_i386 -o hello hello.o

; -----------------------
; Compile 64 Bit Elf File
; -----------------------
; nasm -f elf64 hello.asm
; ld -m elf_x86_64 -o hello hello.o

; --------------------
; Register Explanation
; --------------------
; Acumulator - Input/Output and Most Arithmetic (Used For Passing Function Name To Call To The Kernel Via Interrupt)
; Base - Indexed Addressing (Used For Passing An Argument To The Kernel Via Interrupt)
; Counter - Counting (Used To Store Where Variable Is In Memory)
; Data - Input/Output (Used To Tell Program When To Stop Reading/Writing Variable)

; -----------------------
; Instruction Explanation
; -----------------------
; global - Global Variable
; mov - Copy Data From Right Side To Left Side (Yes, Copy, Not Move)
; int - Interrupt (Make System Call)
; -----------------------
; msg - Name Of String Variable With Message
; len - Name Of Length Of Message Variable

; --------------------
; Variable Explanation
; --------------------
; db - Define Byte (Setup In One Byte Increments)
; equ - Numeric Constant (A Number That'll Never Change)


; Executable Code
section .text
	global _start				; Helps Linker Find Entry Point Of Program (Global Variable)

; Conventional Entry Point Of Elf Program
_start:
; Copy Message Data Into Working Memory (Registers)
	mov edx,len					; Copy Length Of String To Data Register
	mov ecx,msg					; Copy Pointer (reference To msg's location in memory) Of String To Counter Register

; Write Contents Of msg To File Descriptor (One Can Loop These 3 Commands)
	mov ebx,1					; Copy File Descriptor To Base Register (stdin, stdout, stderr (or 0, 1, 2))
	mov eax,4					; Copy Write To File Descriptor Command To Accumulator Register (sys_write)
	int 0x80					; Alert Kernel Via Interrupt To Make System Call Based On Values In ebx and eax.

; Exit Program
	mov ebx,0					; Copy Exit Code 0 To Base Register
	mov eax,1					; Copy Exit Command To Accumulator Register (sys_exit)
	int 0x80					; Alert Kernel Via Interrupt To Make System Call Based On Values In ebx and eax.

; Read Only Variables
section .rodata
	msg db "Hello World!",0xa	; 0xa is shorthand for 0x0a and means newline (\n)
	len equ $-msg				; $ (dollar sign) means current location. $-msg is compile time math to determine how long the message (msg) variable is
