segment .data
	new_line	db	0x0A
segment	.bss
	string 	resb 32
	buf	resd	1

segment .text
lsb:
	mov	[buf], eax
	mov	ebx, 0
	and	al, 00000001b
	mov	bl, al
	mov	eax, [buf]
	shr	eax, 1
	ret

;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

binary_to_ascii:
	cmp 	bl, 0x01
	ja	exit	
	add	bl, 0x30
	ret
exit:
	mov bl, '?'
	ret	

;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

save_to_string:
	mov	edx, string
	add	edx, ecx
	mov	byte	[edx], bl
	ret

binary_to_string:

	mov 	ecx, 31
	call	lsb
	call	binary_to_ascii
	call	save_to_string

loop:	
	dec	ecx
	call	lsb
	call 	binary_to_ascii
	call 	save_to_string
	

	cmp	ecx, 0
	ja	loop

	ret
	


;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

segment .text
	global 	_start
_start:
	mov	eax, 0x00A0

	call binary_to_string

	mov	eax,	4
	mov	ebx,	1
	mov	ecx,	string
	mov	edx,	32
	int	0x80

	mov	eax, 4
	mov	ebx, 1
	mov 	ecx, new_line
	mov	edx, 1
	int	0x80


	mov	eax, 1
	mov 	ebx, 0
	int	0x80


