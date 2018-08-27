; bootloader
%define BASE	0x100	; 0x0100:0x0 = 0x1000
%define BASE_W_OFFSET 0x1000
%define KSIZE	2	; número de sectores de 512 octetos a cargar

[BITS 16]
[ORG 0]

jmp	07C0h:start

msg  db	'LOADING...', 0
bootdrv db 0
maxheads db 0
maxsecn db 0
%include "function.s"

start:
	mov ax, cs
	mov ds, ax
	mov es, ax
	
	mov ax, 0x8000
	mov ss, ax
	mov sp, 0xf000
	
	; recovery of drive's number
	mov [bootdrv], dl

	mov si, msg
	call print

	; loading to ram

	mov ah, 41h ;checking edd presence
	mov bx, 55AAh
	mov dl, [bootdrv]
	int 13h
	jnc edd
	
	mov ax, 0
	mov dl, [bootdrv]
	int 13h ; reset the drive's controller
			
	push es
	mov ax, BASE
	mov es, ax
	mov bx, 0


	mov ah, 2
	mov al, KSIZE
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov dl, [bootdrv]
	int 13h
	pop es

	jmp _start
edd:
	mov si, packet
	mov dl, [bootdrv]
	mov ah,42h
	int 13h
	pop ds

_start: jmp word BASE:0

packet: db 200h ;size
       db 0
       db 4 ;sector amount
       db 0
       dd BASE_W_OFFSET
       dq 1
       dq BASE_W_OFFSET

times 510-($-$$) db 0	; fill the rest of the file with 0
dw 0AA55h		; End bit of the file is AA55
