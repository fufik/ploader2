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

getkey:
	mov ax, 0
	int 16h
	ret

getkey_:
	mov ax, 0
	mov ah, 1
	int 16h
	jz _getkey
	call getkey
_getkey:
	ret
	; al : ascii ==> ax



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

getchar:
	mov ah, 8
	mov bh, 0
	int 10h
	; char al, color bl 

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

