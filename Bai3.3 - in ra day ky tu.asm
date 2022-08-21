.model small
.stack 100
.data
;khai bao bien va hang
CRLF db 13,10,'$'
.code
main proc
;khoi tao DS
    mov ax, @data
    mov ds, ax
;code something
    mov ah,1
    int 21h
    mov bl,al
    mov ah,9    
    lea dx,CRLF
    int 21h
    mov ah,2
    
display:
    cmp bl,'z'
    jg Exit    
    mov dl,bl
    int 21h
    mov dl,20h
    int 21h
    inc bl
    jmp display

Exit:
    mov ah, 4ch
    int 21h    

main endp
;cac chuong trinh con neu co
end main