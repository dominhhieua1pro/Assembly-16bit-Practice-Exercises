.model small
.stack 100
.data
tb1 db "So luong so nguyen to trong day so la: $"
dayso db 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,23,29,31,37,41
countPrime db 0 
x dw ?
so db ?

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,tb1
    int 21h
    
    mov cx,26  ; luu so phan tu cua dayso
    lea si,dayso
lap:
    mov bl,2 
    xor ax,ax
    mov al,[si]
    mov so,al
    cmp so,2
    je primeNumber
    cmp bl,so
    jl chia
    inc si    
    loop lap
    cmp cx,0
    je display
    
    chia:
        xor ax,ax
        mov al,so  
        div bl
        cmp ah,0
        je laptiep 
        inc bl
        cmp bl,so
        je primeNumber
        jmp chia        
        
    primeNumber:
        mov dl, countPrime
        inc dl
        mov countPrime, dl        
        
    laptiep:               
        inc si
        loop lap  
    
    ;display 
    display:
        xor ax,ax
        mov al,countPrime
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
chia2:
    mov dx,0
    div bx
    inc cx
    push dx
    cmp al,0
    je ht
    jmp chia2
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
