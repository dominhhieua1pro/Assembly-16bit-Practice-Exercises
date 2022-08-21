.model small
.stack 100
.data
tb1 db "So luong so nguyen duong trong day so la: $" 
tb2 db 13,10,"So luong so nguyen am trong day so la: $"
tb3 db 13,10,"So luong so 0 la: $"
dayso db 0,-3,-2,-1,0,1,2,3,4,50
countPositive db 0                       
countNegative db 0
countZero db 0 
x dw ?

.code
main proc
    mov ax,@data
    mov ds,ax
       
    mov cx,10  ; luu so phan tu cua dayso
    lea si,dayso
lap: 
    ;xor ax,ax
    mov al,[si]
    cmp al,0
    jg positiveNumber
    jl negativeNumber
    je zeroNumber
    
    positiveNumber: 
        inc countPositive
        jmp laptiep
        
    negativeNumber:
        inc countNegative
        jmp laptiep
        
    zeroNumber:        
        inc countZero
        
    laptiep:               
        inc si
        loop lap  
    
    ;display 
    display:
        mov ah,9
        lea dx,tb1
        int 21h
    
        xor ax,ax
        mov al,countPositive
        mov x,ax 
        call hienthi_decimal 
        
        mov ah,9
        lea dx,tb2
        int 21h
        
        xor ax,ax
        mov al,countNegative
        mov x,ax 
        call hienthi_decimal 
        
        mov ah,9
        lea dx,tb3
        int 21h
        
        xor ax,ax
        mov al,countZero
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
