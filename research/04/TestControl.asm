%include "io.inc"
global CMAIN

    extern _printf
    section .text

CMAIN:
    mov     ebp, esp; for correct debugging
    
    ; m_nextstate = S_START
    mov     eax, S_START
    mov     [m_nextstate], eax
    ; m_loopcount = 0
    mov     eax, 0
    mov     [m_loopcount], eax    
loop:
    ; if (m_loopcount == m_loopmax) goto loop_end
    mov eax, [m_loopcount]
    mov ebx, LOOPMAX
    cmp eax,ebx
    jz  loop_end
    ;
    
    ; m_bFirst = 0
    mov     eax, 0
    mov     [m_bFirst], eax
    
    ;check nextstate
    ;  if (m_nextstate != 0) {
    ;      m_curstate = m_nextstate;
    ;      m_nextstate = 0
    ;      m_bFirst = true;
    ;  }
    mov     eax, [m_nextstate]
    test    eax, eax
    jz      call_cur
    mov     [m_curstate], eax
    mov     eax, 0
    mov     [m_nextstate], eax
    mov     eax, 1
    mov     [m_bFirst], eax

call_cur:
    ;  if (m_curstate != 0) {
    ;      goto [m_curstate]
    mov     eax, [m_curstate]
    test    eax, eax
    jz      loop_next
    jmp     eax
        
loop_next:
    ; if (m_curstate == S_END) goto loop_end
    mov     eax, [m_curstate]
    mov     ebx, S_END
    cmp     eax, ebx
    je      loop_end

    ; m_loopount++
    mov eax, [m_loopcount]
    inc eax
    mov [m_loopcount],eax   
    ; goto loop
    jmp loop
loop_end:
    ret
    
;   [STATEGO OUTPUT START] indent(0) $/^S_/$
;             psggConverterLib.dll converted from psgg-file:TestControl.psgg

;
;    S_END
;
;
S_END:
    jmp     loop_next
;
;    S_PRINT_HELLOWORLD
;
;
S_PRINT_HELLOWORLD:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_HELLOWORLD_init_end
    push     msg_S_PRINT_HELLOWORLD
    call     _printf
    add      esp, 4
S_PRINT_HELLOWORLD_init_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_PRINT_YOURESUNSHINE
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PRINT_YOURESUNSHINE
;
;
S_PRINT_YOURESUNSHINE:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_YOURESUNSHINE_init_end
    push     msg_S_PRINT_YOURESUNSHINE
    call     _printf
    add      esp, 4
S_PRINT_YOURESUNSHINE_init_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_END
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_START
;
;
S_START:
    mov     eax, S_PRINT_HELLOWORLD
    mov     [m_nextstate], eax
    jmp     loop_next


;   [STATEGO OUTPUT END] 
    
    
    ;
    ; DATA
    ;
    section .data
m_loopcount:    dd 0
LOOPMAX:        equ 100
m_curstate:     dd 0
m_nextstate:    dd 0
m_bFirst:       dd 0

;   [STATEGO OUTPUT START] indent(0) $/^S_/->#state_members$
;             psggConverterLib.dll converted from psgg-file:TestControl.psgg

msg_S_PRINT_HELLOWORLD:    db 'Hello, World.', 10, 0
msg_S_PRINT_YOURESUNSHINE:    db 'You are the sunshine.', 10, 0


;   [STATEGO OUTPUT END] 