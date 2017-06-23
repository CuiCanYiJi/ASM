;5-10.asm
data segment
	x1 dw 49,298,23456,65530
	count db 4
	hex db '0123456789ABCDEF'
	mess db 0dh,0ah,'HEX=$'
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
	mov si,0
let0:
	mov dx,offset mess
	mov ah,9
	int 21h
	mov bx,x1[si]
	mov ch,4
	mov cl,4
let1:
	rol bx,cl
	mov ax,bx
	and ax,000fh
	mov di,ax
	mov dl,hex[di]
	mov ah,2
	int 21h
	dec ch
	jnz let1
	add si,2
	dec count
	jnz let0
out1:
	mov ah,4ch
	int 21h
code ends
end start
