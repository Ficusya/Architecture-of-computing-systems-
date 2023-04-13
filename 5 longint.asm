; count amount of negatives in c <= A[i] <= d
org 100h
.Data
N DD 6
A DD 12345678h,36000h,-100h,654321h,17000h,-35000h
c DD -36000h
d DD 36000h 
.Code
mov cx,N
mov dx,0
mov si, offset A
loop_start:
    mov ax, word ptr [SI]+2
    cmp ax,0h
    jge skip ;good
    
    mov bx, word ptr d+2
    cmp ax,bx
    jg skip
    je equal_d 
    
    mov ax, word ptr [SI]+2
    mov bx, word ptr c+2
    cmp ax,bx
    jl skip
    je equal_c
    inc dx    
skip:
    add SI,4
    loop loop_start
    
equal_d PROC
    mov ax, word ptr [SI]
    mov bx, word ptr d
    cmp ax,bx
    jg skip
equal_d endp

equal_c PROC
    mov ax, word ptr [SI]
    mov bx, word ptr c
    cmp ax,bx
    jl skip
equal_c endp

MOV AX,DX
print       proc
        push    ax
        push    bx
        push    cx
        push    dx
        mov     bx,     10          
        mov     cx,     0            
        @@div:
                xor     dx,     dx     
                div     bx
                add     dl,     '0'   
                push    dx             
                inc     cx              
                test    ax,     ax     
        jnz     @@div                 
        @@show:
                mov     ah,     02h 
                pop     dx             
                int     21h            
        loop    @@show                 
    pop     dx
    pop     cx
    pop     bx
    pop     ax
        ret
print       endp
ret  