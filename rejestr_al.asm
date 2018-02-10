segment	.bss
char 	resb	1
segment .text

print:
	mov	[char], al
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, char
	mov	edx, 1
	int 0x80
	ret

;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

segment .text
	global 	_start
_start:	mov	al, 'F'
	call	print
	mov al, 0x0A
	call	print
	mov	eax, 1
	mov 	ebx, 0
	int	0x80


