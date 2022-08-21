.model small
.stack 100
.data
tb1 db "Tong cac so trong day so la: $"
dayso db 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20 
tong dw 0

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,tb1
    int 21h
    
    mov cx,21  ; so phan tu cua dayso
    lea si,dayso
lap: 
    xor ax,ax
    mov al,[si]  
    mov bx,tong
    add bx,ax
    mov tong,bx
    inc si
    loop lap  

    ;display
    call hienthi_decimal
    
    ;exit
    mov ah,4ch
    int 21h
    
main endp

hienthi_decimal proc    
    mov ax,tong
    mov bx,10
    mov cx,0
chia:
    mov dx,0
    div bx
    inc cx
    push dx
    cmp al,0
    je ht
    jmp chia
ht:
    pop dx 
    add dl,30h
    mov ah,2
    int 21h
    dec cx
    cmp cx,0
    jne ht
    ret
hienthi_decimal endp

end main
