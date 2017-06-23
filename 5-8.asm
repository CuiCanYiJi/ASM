;5-8.asm
data segment
	mess0 db 0ah,0dh,'1. input string'
	      db 0ah,0dh,'2. calculate cube'
	      db 0ah,0dh,'3. exit'
	      db 0ah,0dh,'select:$'
	mess1 db 0ah,0dh,'input:$'
	mess2 db 0ah,0dh,'output:$'
	buff  db 10,?,10 dup(?)
	x     db 3 dup(?)
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
let0:
	mov dx,offset mess0
	mov ah,9
	int 21h
	mov ah,1
	int 21h
	cmp al,'1'
	jz prog1
	cmp al,'2'
	jz prog2
	jmp prog3
prog1:
	mov dx,offset mess1
	mov ah,9
	int 21h
	mov dx,offset buff
	mov ah,10
	int 21h
	mov cl,buff+1
	mov bx,2
	mov dx,offset mess2
	mov ah,9
	int 21h
let1:
	and buff[bx],0dfh
	mov dl,buff[bx]
	mov ah,2
	int 21h
	inc bx
	dec cl
	jnz let1
	jmp let0
prog2:
	mov dx,offset mess1
	mov ah,9
	int 21h
	mov ah,1
	int 21h
	cmp al,27
	jz prog3
	cmp al,'0'
	jb prog2
	cmp al,'9'
	ja prog2
	and al,0fh
	mov ah,0
	mov bl,al
	mul bl
	mul bl
	mov bl,10
	div bl
	add ah,30h
	mov x,ah
	cmp al,10
	jb let2
	mov ah,0
	div bl
	add ah,30h
	mov x+1,ah
	add al,30h
	mov x+2,al
	jmp let3
let2:
	add al,30h
	mov x+1,al
let3:
	mov ax,0
	mov dx,offset mess2
	mov ah,9
	int 21h
	mov dl,x+2
	mov ah,2
	int 21h
	mov dl,x+1
	int 21h
	mov dl,x
	int 21h
	mov word ptr x,0
	mov x+2,0
	jmp let0
prog3:
	mov ah,4ch
	int 21h
code ends
end start

