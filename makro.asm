segment .data
	buf	times 100 db 0

segment .text
%macro WczytajZnak 1	

mov	eax, 3
mov	ebx, 0
mov	ecx, %1
mov	edx, 100
int	0x80
%endmacro

%macro WyswietlZnak 1
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, %1
	mov	edx, 1
	int	0x80

loop:
	inc	ecx
	cmp	byte	[ecx], 0
	je	end
	
	mov	eax, 4
	mov	ebx, 1
	mov	edx, 1
	int	0x80
	jmp	loop
end:
%endmacro


global _start
_start:
	
	WczytajZnak buf
	WyswietlZnak buf

	mov	eax, 1
	mov	ebx, 0
	int	0x80
