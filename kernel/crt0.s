.section .text

.global _start
_start:
    movl $0, %ebp
    pushl %ebp
    pushl %ebp
    movl %esp, %ebp

    call initialize_standard_library
    call _init
    popl %edi
    popl %esi

    call main

    movl %eax, %edi
    call exit
.size _start, . - _start
