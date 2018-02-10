segment .data
	new_line db 0x0A
segment .bss

	tbl	resb	10

segment .text
	global	_start

_start:	mov ecx, 0
	mov eax, 10
	mov ebx, tbl
	mov edx, 0x30

loop:
	mov [ebx], edx;
	inc ecx
	inc ebx
	inc edx
	cmp ecx, eax
	jnz loop
	

	mov eax, 0x04
	mov ebx, 0x01
	mov ecx, tbl
	mov edx, 10
	int 0x80

	mov eax, 0x04
	mov ebx, 0x01
	mov ecx, new_line
	mov edx, 1
	int 0x80

	mov eax, 0x01
	mov ebx, 0x05
	int 0x80






