;5-6.asm
data segment
	x db 4 dup(?)
	z db ?
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
	mov cx,2
	mov si,0
let0:
	mov ah,1
	int 21h
	cmp al,0dh
	jz let1
	and al,0fh
	mov x[si],al
	inc si
	jmp let0
let1:
	mov ah,2
	mov dl,0ah
	int 21h
	dec cx
	jnz let0
	mov ax,0
	mov al,x
	mov cl,4
	shl al,cl
	add al,x+1
	mov bl,x+2
	shl bl,cl
	add bl,x+3
	add al,bl
	daa
	jnc let2
	mov z,'1'
let2:
	mov cl,4
	shl ax,cl
	rol al,cl
	add ax,3030h
	mov bx,ax
	mov dl,0ah
	mov ah,2
	int 21h
	cmp z,'1'
	jnz out1
	mov dl,z
	int 21h
out1:
	mov dl,bh
	int 21h
	mov dl,bl
	int 21h
	mov ah,4ch
	int 21h
code ends
end start
