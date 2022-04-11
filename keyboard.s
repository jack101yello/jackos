	.file	"keyboard.c"
	.text
	.section	.rodata
.LC0:
	.string	"Error"
.LC1:
	.string	"ESC"
.LC2:
	.string	"Unknown key down"
.LC3:
	.string	"key up"
.LC4:
	.string	"Unknown key up"
	.text
	.globl	print_letter
	.type	print_letter, @function
print_letter:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	movzbl	-4(%rbp), %eax
	testl	%eax, %eax
	je	.L2
	cmpl	$1, %eax
	je	.L3
	jmp	.L9
.L2:
	leaq	.LC0(%rip), %rdi
	call	print@PLT
	jmp	.L5
.L3:
	leaq	.LC1(%rip), %rdi
	call	print@PLT
	jmp	.L5
.L9:
	movzbl	-4(%rbp), %eax
	testb	%al, %al
	js	.L6
	leaq	.LC2(%rip), %rdi
	call	print@PLT
	jmp	.L10
.L6:
	cmpb	$-71, -4(%rbp)
	ja	.L8
	leaq	.LC3(%rip), %rdi
	call	print@PLT
	movzbl	-4(%rbp), %eax
	addl	$-128, %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	print_letter
	jmp	.L10
.L8:
	leaq	.LC4(%rip), %rdi
	call	print@PLT
.L10:
	nop
.L5:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	print_letter, .-print_letter
	.section	.rodata
.LC5:
	.string	"\n"
	.text
	.type	keyboard_callback, @function
keyboard_callback:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$96, %edi
	call	port_byte_in@PLT
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	print_letter
	leaq	.LC5(%rip), %rdi
	call	print@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	keyboard_callback, .-keyboard_callback
	.globl	init_keyboard
	.type	init_keyboard, @function
init_keyboard:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	irq1@GOTPCREL(%rip), %rax
	movzbl	%al, %eax
	leaq	keyboard_callback(%rip), %rsi
	movl	%eax, %edi
	call	register_interrupt_handler@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	init_keyboard, .-init_keyboard
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
