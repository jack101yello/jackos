; Ensures that the kernel boots into main()
[bits 32]
[extern main]
call main   ; Invoke main()
jmp $   ; hang forever once we return from the kernel