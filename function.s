; function.s
[BITS 16]

print:
	lodsb

	cmp al, 0
	je _print
	mov bl, 4
	call putchar_
	;call getcurs
	;inc dl
	;call putcurs
	jmp print
_print:
	ret

putchar:
	; char al, color bl
	mov ah, 9
	mov bh, 0
	mov cx, 1
	int 10h
	ret

putchar_: ; mode teletype
	; char al, color bl
	mov ah, 0Eh
	mov bh, 0
	int 10h
	ret

getcurs:
	mov ah, 3
	mov bh, 0
	int 10h
	ret
	; x: dl, y: dh

putcurs:
	; x : dl, y : dh
	mov ah, 2
	mov bh, 0
	int 10h
	ret

