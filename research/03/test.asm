%include "io.inc"
; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------

        global    CMAIN
        extern  _printf
        section   .text
CMAIN:
        mov     ebp, esp; for correct debugging
        
        push    message
        call    _printf
        add     esp, 4
        ret
message:
        db      'Hello, World', 10, 0
        
        