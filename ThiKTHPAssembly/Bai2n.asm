.model small
.stack 100
.data
tb1 db "So phan tu am la: $" 
tb2 db 13,10,"So phan tu duong la: $"
dayso db -11,-1,2,-3,4,5
demSoDuong db 0                       
demSoAm db 0
x dw ?

.code
main proc
    mov ax,@data
    mov ds,ax
       
    mov cx,6  
    lea si,dayso
lap: 
    mov al,[si]
    cmp al,0
    jg soDuong
    jl soAm
    jmp lapTiep
    
    soDuong: 
        inc demSoDuong
        jmp laptiep
        
    soAm:
        inc demSoAm
        jmp laptiep
        
    lapTiep:               
        inc si
        loop lap  
    
    hienThi:     
        mov ah,9
        lea dx,tb1
        int 21h
        
        xor ax,ax
        mov al,demSoAm
        mov x,ax 
        call hienThiThapPhan
        
        mov ah,9
        lea dx,tb2
        int 21h
    
        xor ax,ax
        mov al,demSoDuong
        mov x,ax 
        call hienThiThapPhan 
        
    mov ah,4ch
    int 21h
    
main endp

hienThiThapPhan proc    
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
hienThiThapPhan endp

end main
