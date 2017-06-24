;6-1.asm
data segment
	a1 db 'Hello world!'
	a2 db 0
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
	mov dh,5
	mov dl,16
	mov bl,4
	mov si,0
show_str:
	mov ax,0b800h
	mov es,ax
	mov ax,160
	mul dh
	mov di,ax
	sal dl,1
	mov dh,0
	add di,dx
	mov cx,a2-a1
let1:
	mov al,[si]
	mov es:[di],al
	mov byte ptr es:[di+1],bl
	inc si
	inc bl
	add di,2
	loop let1
	mov ah,4ch
	int 21h
code ends
end start
