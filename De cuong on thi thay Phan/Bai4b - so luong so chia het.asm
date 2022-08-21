.model small
.stack 100
.data
tb1 db "So luong cac so chia het cho 5 trong day so la: $"
dayso db 0,1,2,3,4,5,6,7,8,9,10,15,20,25,30,35,40,45,50,100
demsochiahet db 0
x dw ?

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,tb1
    int 21h
    
    mov cx,20  ; day so co 20 phan tu 
    lea si,dayso
    xor bx,bx
    mov bl,5  ; chia cho so # thi sua gia tri 5
lap: 
    xor ax,ax
    xor dx,dx
    mov al,[si]  
    div bl
    cmp ah,0
    jne laptiep 
    inc demsochiahet
    
    laptiep:               
        inc si
        loop lap                
    
    ;display
    xor ax,ax
    mov al,demsochiahet
    mov x,ax
    call hienthi_decimal
    
    ;exit
    mov ah,4ch
    int 21h
    
main endp

hienthi_decimal proc    
    mov ax,x
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
