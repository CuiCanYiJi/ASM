;5-7.asm
data segment
	x db 2 dup(?)
	mess1 db 0dh,0ah,'decimal=$'
	mess2 db 0dh,0ah,'HEX=$'
data ends
code segment
	assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
let0:
	mov x,0
	mov x+1,0
	mov si,0
	mov dx,offset mess1
	mov ah,9
	int 21h
let1:
	mov ah,1
	int 21h
	cmp al,27
	jz out1
	cmp al,0dh
	jz let2
	and ax,000fh
	mov x[si],al
	inc si
	jmp let1
let2:
	mov dx,offset mess2
	mov ah,9
	int 21h
	cmp si,1
	ja let3
	mov bl,x
	mov cl,1
	jmp let5
let3:
	mov al,x
	mov cl,10
	mul cl
	add al,x+1
	mov ah,0
	mov bl,16
	div bl
	mov bx,ax
	mov cl,2
let4:
	cmp bl,10
	jl let5
	add bl,7
let5:
	add bl,30h
	mov dl,bl
	mov ah,2
	int 21h
	mov bl,bh
	dec cl
	jnz let4
	jmp let0
out1:
	mov ah,4ch
	int 21h
code ends
end start
