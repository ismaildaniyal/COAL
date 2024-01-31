[org 0x100]
jmp start
seed: dw 98
length: dw 5; length of snake
loc: dw 804,806,808,810,812,0,0,0,0,0
count:dd 0
bool: dw 0
eat: dw 0
score : dw 48
counter: db 'Score  ',0
name1: db'21F9095   Ahmad',0
name2: db'21F9345   Ismail',0
info1: db'W for UP',0
info2: db'S for DOWN',0
info3: db'A for RIGHT',0
info4: db'D for LEFT',0
clrscr:
push ax
push es
push di
push cx
xor di,di
mov ax,0xb800
mov es,ax
mov ax,0x0720
mov cx, 0
next:
mov word [es:di],ax
add di,2
cmp di,4000
jne next
pop cx
pop di
pop es
pop ax
ret 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
delaY:
mov dword[count],400000
delaYLoop:
sub dword [count],1
cmp dword[count],0
jne delaYLoop
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printboundary:
push ax
push cx
push es
push di
mov di,0
mov ax,0xb800
mov es,ax
top:
mov word [es:di],0x072D
add di,2
cmp di,160
jne top
LR:
mov word [es:di],0x077C
add di,158
mov word [es:di],0x077C
add di,2
cmp di,3840
jnz LR
bottom:
mov word [es:di],0x072D
add di,2
cmp di,3998
jne bottom
pop di
pop es
pop cx
pop ax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printsnake:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push es
push di
mov bx,[bp+4]
mov cx,[bp+6]
mov ax,0xb800
mov es,ax
l1:
   mov word di,[bx]
   mov word [es:di],0x072A
   add bx,2
   dec cx
   cmp cx,1
   jne l1
    mov word di,[bx]
   mov word [es:di],0x0701
pop di
pop es
pop dx
pop cx
pop bx
pop ax
pop bp
ret 4


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printfood:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push es
push di
mov cx,3998
mov ax,0xb800
mov es,ax

mov bx,[bp+4]
mov di,[bx]
mov word [es:di],0x0720
mov ax,di
shl ax,4
div cx
mov di,dx
mov word [bx],di
mov word [es:di],0x0724
pop di
pop es
pop dx
pop cx
pop bx
pop ax
pop bp
ret 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

hitting:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push si
push di
mov di,[bp+6]
mov ax,[bp+4]
dec ax
mov cx,ax
shl cx,1

add di,cx
mov cx,160

mov dx,0
mov ax,[di]
div cx
cmp dx,0
je change

mov dx,0
mov ax,[di]
add ax,2
div cx
cmp dx,0
je change
cmp word[di],158
jle change
cmp word [di],3840
jge change
return:
pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret 4
change:
mov word [bool],1
jmp return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gameover:
call clrscr
push ax
push es
push di
mov di,1994
mov ax,0xb800
mov es,ax
mov word [es:di],0x0745
add di,2
mov word [es:di],0x076E
add di,2
mov word [es:di],0x0764
call delaY
call delaY
pop di

pop es
pop ax
jmp exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
right:
push bp
mov bp,sp
push ax
push bx
push cx
push es
push di
mov bx,[bp+4]
mov di,[bx]
mov ax,0xb800
mov es,ax
mov word [es:di],0x0720
mov di,[bp+4]
mov cx,[bp+6]
dec cx
iterate1:
mov bx,[di+2]
mov word [di],bx
add di,2
dec cx
cmp cx,0
jne iterate1
mov bx,[di]
add bx,2
mov word[di],bx
pop di
pop es
pop cx
pop bx
pop ax
pop bp
ret 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
left:
push bp
mov bp,sp
push ax
push bx
push cx
push es
push di
mov bx,[bp+4]
mov di,[bx]
mov ax,0xb800
mov es,ax
mov word [es:di],0x0720
mov di,[bp+4]
mov cx,[bp+6]
dec cx
iterate2:
mov bx,[di+2]
mov word [di],bx
add di,2
dec cx
cmp cx,0
jne iterate2
mov bx,[di]
sub bx,2
mov word[di],bx
pop di
pop es
pop cx
pop bx
pop ax
pop bp
ret 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
up:
push bp
mov bp,sp
push ax
push bx
push cx
push es
push di
mov bx,[bp+4]
mov di,[bx]
mov ax,0xb800
mov es,ax
mov word [es:di],0x0720
mov di,[bp+4]
mov cx,[bp+6]
dec cx
iterate3:
mov bx,[di+2]
mov word [di],bx
add di,2
dec cx
cmp cx,0
jne iterate3
mov bx,[di]
sub bx,160
mov word[di],bx
pop di
pop es
pop cx
pop bx
pop ax
pop bp
ret 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
down:
push bp
mov bp,sp
push ax
push bx
push cx
push es
push di
mov bx,[bp+4]
mov di,[bx]
mov ax,0xb800
mov es,ax
mov word [es:di],0x0720
mov di,[bp+4]
mov cx,[bp+6]
dec cx
iterate4:
mov bx,[di+2]
mov word [di],bx
add di,2
dec cx
cmp cx,0
jne iterate4
mov bx,[di]
add bx,160
mov word[di],bx
pop di
pop es
pop cx
pop bx
pop ax
pop bp
ret 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
eatfood:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push si
push di
mov bx,[bp+8]
add word [bx],1
mov bx,[bp+6]
add word [bx],1
mov cx,[bx]
mov di,cx
dec di
shl di,1
mov bx,[bp+4]
eat1:
     mov ax,[bx+di-2]
     mov word [bx+di],ax
     dec cx
     sub di,2
     cmp cx,1
     jne eat1
mov ax,[bx+di+2]
sub ax,2
mov word[bx+di],ax
pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret 6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
eatcheck:
push bp
mov bp,sp
push ax
push bx
push si
push di
mov bx,[bp+6]
mov ax,[bp+8]
mov si,[bp+4]
dec bx
shl bx,1
mov di,si
add di,bx
cmp word [di],ax
jne no
mov word [eat],1
no:
pop di
pop si
pop bx
pop ax
pop bp
ret 6  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
selfdeath:
push bp
mov bp,sp
push ax
push bx
push cx
push si
push di
mov bx,[bp+6]
mov cx,bx
dec cx
mov si,[bp+4]
dec bx
shl bx,1
mov di,si
add di,bx
self:
     mov bx,[si]
     cmp word [di],bx
     je changing
     add si,2
     dec cx
     cmp cx,0
     jne self
back:
pop di
pop si
pop cx
pop bx
pop ax
pop bp
ret 4
   
     
changing:
mov word [bool],1
jmp back
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
intro:
push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 mov ax, 0xb800
 mov es, ax 
 mov al, 80
 mul byte [bp+10] 
 add ax, [bp+12] 
 shl ax, 1 
 mov di,ax 
 mov si, [bp+6] 
 mov cx, [bp+4]
 mov ah, [bp+8] 
 cld
 nextintro: lodsb
 stosw 
 loop nextintro 
 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
scoredisplay:
 push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 mov ax, 0xb800
 mov es, ax 
 mov al, 80
 mul byte [bp+10] 
 add ax, [bp+12] 
 shl ax, 1 
 mov di,ax 
 mov si, [bp+6] 
 mov cx, [bp+4]
 mov ah, [bp+8] 
 cld
 scoreintro: lodsb
 stosw 
 loop scoreintro
 mov al,[bp+14]
 mov ah,0x01
 mov word [es:di],ax 
 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 12
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
call clrscr
 mov ax, 30 
 push ax  
 mov ax, 15
 push ax 
 mov ax, 1 
 push ax 
 mov ax,name1
 push ax 
 mov ax,15
 push ax
 call intro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 mov ax, 30 
 push ax  
 mov ax, 16
 push ax 
 mov ax, 1 
 push ax 
 mov ax,name2 
 push ax 
 mov ax,16
 push ax
 call intro
call delaY
call delaY
call clrscr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 mov ax, 30 
 push ax  
 mov ax, 14
 push ax 
 mov ax, 1 
 push ax 
 mov ax,info1 
 push ax 
 mov ax,8
 push ax
 call intro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 mov ax, 30 
 push ax  
 mov ax, 15
 push ax 
 mov ax, 1 
 push ax 
 mov ax,info2 
 push ax 
 mov ax,10
 push ax
 call intro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 mov ax, 30 
 push ax  
 mov ax, 16
 push ax 
 mov ax, 1 
 push ax 
 mov ax,info3
 push ax 
 mov ax,11
 push ax
 call intro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 mov ax, 30 
 push ax  
 mov ax, 17
 push ax 
 mov ax, 1 
 push ax 
 mov ax,info4
 push ax 
 mov ax,10
 push ax
 call intro
call delaY
call delaY
call delaY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
call clrscr

call printboundary
mov ax,[score]
push ax
mov ax, 8 
 push ax  
 mov ax, 0
 push ax 
 mov ax, 1 
 push ax 
 mov ax,counter
 push ax 
 mov ax,7
 push ax
call scoredisplay
mov ah,00h
int 1ah
mov ax,dx
xor dx,dx
mov bx,1998
div bx
add dx,dx
mov word [seed],dx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ax,seed
push ax
call printfood
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ax,[length]
push ax
mov ax,loc
push ax
call printsnake
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
run:
mov ah,0
int 0x16
cmp al,0x77
je upmotion
cmp al,0x73
je downmotion
cmp al,0x64
je rightmotion
cmp al,0x61
je leftmotion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
upmotion:
mov bx,[length]
push bx
mov bx,loc
push bx
call up
jmp checklist
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
downmotion:
mov bx,[length]
push bx
mov bx,loc
push bx
call down
jmp checklist
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rightmotion:
mov bx,[length]
push bx
mov bx,loc
push bx
call right
jmp checklist
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
leftmotion:
mov bx,[length]
push bx
mov bx,loc
push bx
call left
jmp checklist
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
checklist:
mov ax,[length]
push ax
mov ax,loc
push ax
call selfdeath
mov ax,loc
push ax
mov ax,[length]
push ax
call hitting
cmp word [bool],1
je gameover
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ax,[seed]
push ax
mov ax,[length]
push ax
mov ax,loc
push ax
call eatcheck
cmp word [eat],1
jne pass
mov ax,score
push ax
mov ax,length
push ax
mov ax,loc
push ax
call eatfood
mov ax,seed
push ax
call printfood
mov ax,[score]
push ax
mov ax, 8 
 push ax  
 mov ax, 0
 push ax 
 mov ax, 1 
 push ax 
 mov ax,counter
 push ax 
 mov ax,7
 push ax
call scoredisplay

pass:
mov word[eat],0
mov ax,[length]
push ax
mov ax,loc
push ax
call printsnake


jmp run
exit:
mov ax,0x4c00
int 0x21