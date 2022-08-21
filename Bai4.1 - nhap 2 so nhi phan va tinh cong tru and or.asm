.model small
.stack 100
.data
    A dw ?
    B dw ?
    tb1 db 'So A 16bit: $'
    tb2 db 10, 13, 'So B 16bit: $'
    tb3 db 10, 13, 'A + B = $'
    tb4 db 10, 13, 'A - B = $'
    tb5 db 10, 13, 'A OR B = $'
    tb6 db 10, 13, 'A AND B = $'
    
MAIN PROC
    mov ax, @data
    mov ds,ax
;Input A 16bit   
    mov bx, 0
    mov cx, 16
    mov ah,9
    lea dx,tb1
    int 21h    
Lap1:
    mov ah,1
    int 21h
    sub al,30h
    shl bx,1
    add bl,al
    loop Lap1
    mov A, bx
    
;Input B 16bit   
    mov bx,0
    mov cx, 16
    lea dx, tb2
    mov ah,9
    int 21h     
Lap2:
    mov ah,1
    int 21h
    sub al,30h
    shl bx,1
    add bl, al
    loop Lap2
    mov B,bx

;A+B    
    mov ah,9
    lea dx,tb3
    int 21h        
    mov bx,A
    add bx,B     
    mov cx,16
    mov dl,30h  ; bit dau tien the hien viec tran so nguyen
    adc dl,0  ; dx cong them 1 neu co co flag tran so nguyen
    mov ah,2
    int 21h     
Lap3:
    mov dl,30h
    shl bx,1  ; bit day ra ngoai luu vao flag
    adc dl,0  ; dl = dl + 0 + flag
    mov ah,2
    int 21h
    loop Lap3  

;A-B    
    mov ah,9
    lea dx,tb4
    int 21h    
    mov bx,A
    sub bx,B
    mov cx,16
Lap4:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop Lap4

;A OR B    
    mov ah,9
    lea dx,tb5
    int 21h      
    mov bx,A
    or bx,B
    mov cx,16
Lap5:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop Lap5
    
;A AND B    
    mov ah,9
    lea dx,tb6
    int 21h
    mov bx,A
    and bx,B
    mov cx,16
Lap6:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop Lap6

;Exit    
    mov ah,4ch
    int 21h
main endp
end main