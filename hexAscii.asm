segment	.bss
char 	resb	1
counter resb 	0
segment .text

hex_to_ascii:
	cmp 	al, 0x0a
	ja	greater

	add	al, 0x21
	ret
greater:
	mov	al, '?'
	ret	
;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

print:
	mov	[char], al
	mov 	[counter], ecx
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, char
	mov	edx, 1
	int 0x80
	mov	al, [char]
	mov ecx, [counter]
	ret


;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

segment .text
	global 	_start
_start:
	mov	ecx, 0
	mov	al, 0x00
loop:
	call	hex_to_ascii
	call	print
	add	ecx, 1
	sub	al, 0x20
	cmp	ecx, 0x14
	jbe	loop

	mov	al, 0x0A
	call	print
	;mov 	eax, 4
	;mov	ebx, 1
	;mov	ecx, 0x0a
	;mov	edx, 1
	;int	0x80

	mov	eax, 1
	mov 	ebx, 0
	int	0x80


