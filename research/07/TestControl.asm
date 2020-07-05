%include "io.inc"
global CMAIN

    extern _printf
     extern  _GetTickCount@0
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
    
err_end:
    push     eax
    call     _printf
    add      esp, 4
    ret
    
;   [STATEGO OUTPUT START] indent(0) $/^S_/$
;             psggConverterLib.dll converted from psgg-file:TestControl.psgg

;
;    S_0000
;    Get Tick Count and fillter 0x7.
;    Branch by eax
;
S_0000:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_0000_init_end
    call _GetTickCount@0
    and  eax, 0x7
    mov [m_num], eax
S_0000_init_end:
    cmp   eax, 0
    jne    S_0000_skip_0
    mov     eax, S_PRINT_0
    mov     [m_nextstate], eax
    jmp  S_0000_branch_end
S_0000_skip_0 :
    cmp   eax, 1
    jne    S_0000_skip_1
    mov     eax, S_PRINT_1
    mov     [m_nextstate], eax
    jmp  S_0000_branch_end
S_0000_skip_1 :
    cmp   eax, 2
    jne    S_0000_skip_2
    mov     eax, S_PRINT_2
    mov     [m_nextstate], eax
    jmp  S_0000_branch_end
S_0000_skip_2 :
    mov     eax, S_PRINT_ETC
    mov     [m_nextstate], eax
    jmp  S_0000_branch_end
S_0000_branch_end:
    jmp     loop_next
;
;    S_0001
;
S_0001:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_0001_init_end
    mov dword [m_cnt], 5
S_0001_init_end:
    mov     al, [m_cnt]
    add     al, 48
    mov     byte [msg_S_0001 + 11], al
    push     msg_S_0001
    call     _printf
    add      esp, 4
    mov ecx, [m_cnt]
    mov eax, ecx
    dec ecx
    mov [m_cnt], ecx
    test    eax, eax
    jnz     loop_next
S_0001_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_END
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_0002
;
S_0002:
S_0002_branch_end:
    jmp     loop_next
;
;    S_END
;
S_END:
    jmp     loop_next
;
;    S_GSB000
;
S_GSB000:
    ; if m_callstack_level >= MAX_CALL_STACK :
        mov eax, [m_callstack_level]
        cmp eax, MAX_CALL_STACK
        jl S_GSB000_gosub_less
        mov eax, msg_stackoverflow
        jmp err_end
    S_GSB000_gosub_less:
         mov edi, [m_callstack_level]
         mov dword [m_callstack + edi], S_END ; m_callstack[m_callstack_level] = nex
         inc edi
         mov [m_callstack_level], edi                ; m_callstack_level ++
         mov     eax, S_SBS000
         mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PASS
;
S_PASS:
S_PASS_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_0001
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PRINT_0
;
S_PRINT_0:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_0_init_end
    push     msg_S_PRINT_0
    call     _printf
    add      esp, 4
S_PRINT_0_init_end:
S_PRINT_0_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_PASS
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PRINT_1
;
S_PRINT_1:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_1_init_end
    push     msg_S_PRINT_1
    call     _printf
    add      esp, 4
S_PRINT_1_init_end:
S_PRINT_1_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_PASS
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PRINT_2
;
S_PRINT_2:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_2_init_end
    push     msg_S_PRINT_2
    call     _printf
    add      esp, 4
S_PRINT_2_init_end:
S_PRINT_2_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_PASS
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PRINT_ETC
;
S_PRINT_ETC:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_ETC_init_end
    mov     al, [m_num]
    add     al, 48
    mov     byte [msg_S_PRINT_ETC + 6], al
    push     msg_S_PRINT_ETC
    call     _printf
    add      esp, 4
S_PRINT_ETC_init_end:
S_PRINT_ETC_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_PASS
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PRINT_HELLOWORLD
;
S_PRINT_HELLOWORLD:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_HELLOWORLD_init_end
    push     msg_S_PRINT_HELLOWORLD
    call     _printf
    add      esp, 4
S_PRINT_HELLOWORLD_init_end:
S_PRINT_HELLOWORLD_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_PRINT_YOURESUNSHINE
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PRINT_SUBROUTINE
;
S_PRINT_SUBROUTINE:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_SUBROUTINE_init_end
    push     msg_S_PRINT_SUBROUTINE
    call     _printf
    add      esp, 4
S_PRINT_SUBROUTINE_init_end:
S_PRINT_SUBROUTINE_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_RET000
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_PRINT_YOURESUNSHINE
;
S_PRINT_YOURESUNSHINE:
    mov     eax, [m_bFirst]
    test    eax, eax
    jz      S_PRINT_YOURESUNSHINE_init_end
    push     msg_S_PRINT_YOURESUNSHINE
    call     _printf
    add      esp, 4
S_PRINT_YOURESUNSHINE_init_end:
S_PRINT_YOURESUNSHINE_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_0000
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_RET000
;
S_RET000:
    ; if m_callstack_level <= 0
        mov eax, [m_callstack_level]
        cmp eax, 0
        jg S_RET000_return_grater
        mov eax, msg_stackunderflow
        jmp err_end
    S_RET000_return_grater:
        mov edi, [m_callstack_level]    ; m_callstack_level = m_callstack_level - 1
        dec edi
        mov [m_callstack_level], edi
        mov eax, dword [m_callstack + edi]
        mov [m_nextstate],eax
    jmp     loop_next
;
;    S_SBS000
;
S_SBS000:
S_SBS000_branch_end:
    mov     eax, [m_nextstate]
    test    eax, eax
    jnz      loop_next
    mov     eax, S_PRINT_SUBROUTINE
    mov     [m_nextstate], eax
    jmp     loop_next
;
;    S_START
;
S_START:
    mov     eax, S_GSB000
    mov     [m_nextstate], eax
    jmp     loop_next


;   [STATEGO OUTPUT END] 

;   [STATEGO OUTPUT START] indent(0) $/^E_/$        
;             psggConverterLib.dll converted from psgg-file:TestControl.psgg



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

;                    0 1 2 3 4 5 6 7 8 9
m_callstack:      dd 0,0,0,0,0,0,0,0,0,0
MAX_CALL_STACK    equ 10
m_callstack_level dd 0
m_callstack_index dd 0
msg_stackoverflow:     db 'STACK OVER FLOW', 10, 0
msg_stackunderflow:    db 'STACK UNDER FLOW', 10, 0

;   [STATEGO OUTPUT START] indent(0) $/./->#state_members$
;             psggConverterLib.dll converted from psgg-file:TestControl.psgg

m_num: dd 0
m_cnt : dd   5
;                     0123456789012
msg_S_0001:    db 'Count down  .', 10, 0
msg_S_PRINT_0:    db 'It is Zero!', 10, 0
msg_S_PRINT_1:    db 'It is First!', 10, 0
msg_S_PRINT_2:    db 'It is Second!', 10, 0
;                     01234567
msg_S_PRINT_ETC:    db 'It is   ', 10, 0
msg_S_PRINT_HELLOWORLD:    db 'Hello, World.', 10, 0
msg_S_PRINT_SUBROUTINE:    db 'IN THE SUBROUTINE.', 10, 0
msg_S_PRINT_YOURESUNSHINE:    db 'You are the sunshine.', 10, 0


;   [STATEGO OUTPUT END] 