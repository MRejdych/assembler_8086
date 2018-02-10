segment .data
	new_line	db	0x0A
segment	.bss
	string 	resb 9
	buf	resd	1
	counter resd	1
	hex	resb	1

segment .text
lsb:
	mov	dword [buf], eax
	mov	ebx, 0
	and	al, 00001111b
	mov	bl, al
	mov	eax, [buf]
	shr	eax, 4
	ret

;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

hex_to_ascii:
	cmp 	bl, 0x0A
	jae	greater
	
	add	bl, 0x30
	ret
greater:
	cmp	bl, 0x0F
	ja	exit
	add	bl, 0x37
	ret
exit:
	mov bl, '?'
	ret	


;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

save_to_string:
	mov	edx, string
	add	edx, ecx
	mov	byte	[edx], bl
	ret

hex_to_string:

	mov 	ecx, 7
loop:	
	call	lsb
	call 	hex_to_ascii
	call 	save_to_string
	
	dec	ecx
	cmp	ecx, 0
	ja	loop
	
	call	lsb
	call 	hex_to_ascii
	call	save_to_string
	ret
	


;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

segment .text
	global 	_start
_start:
	mov	eax, 0xABCDEF12
	
	mov	byte [string], 'X'
	call 	hex_to_string
	add	edx, 	1
	mov	eax,	4
	mov	ebx,	1
	mov	ecx,	string
	mov	edx,	8
	int	0x80

	mov	eax, 4
	mov	ebx, 1
	mov 	ecx, new_line
	mov	edx, 1
	int	0x80


	mov	eax, 1
	mov 	ebx, 0
	int	0x80


