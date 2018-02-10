segment .data

string 	db	'Ala ma kota.',0
strlen	equ	$-string

segment	.bss
buf	resb	1

segment .text

count:
	cld
	mov	edi, ebx

loop:
	scasb
	jne	J1
	inc	edx

J1:
	dec 	ecx
	cmp	ecx, 1
	jae	loop
	ret


global	_start

_start:
	xor	eax, eax
	mov	al, 'a'
	mov	ebx, string
	mov 	ecx, strlen
	mov	edx, 0

	call	count
	mov	[buf], edx
	add	byte	[buf], 0x30

	mov	eax, 4
	mov	ebx, 1
	mov	ecx, buf
	mov	edx, 1
	int	0x80



	mov	eax, 1
	mov	ebx, 0
	int	0x80


