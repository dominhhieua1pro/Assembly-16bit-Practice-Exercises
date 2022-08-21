.model small
.stack 100
.data
;khai bao bien va hang
upper db 13,10,"Ky tu HOA$"
lower db 13,10,"Ky tu thuong$"
differ db 13,10,"Ky tu khac $"
.code
main proc
;khoi tao DS
    mov ax, @data
    mov ds, ax
;code something
    mov ah,1
    int 21h
    mov ah,9
    cmp al,'A'
    jnge elseif
    cmp al,'Z'
    jnle elseif
    lea dx,upper
    mov ah,9
    int 21h
    jmp Exit
    
elseif:
    cmp al,'a'
    jnge else
    cmp al,'z'
    jnle else 
    lea dx,lower
    mov ah,9
    int 21h
    jmp Exit

else:
    lea dx,differ
    mov ah,9
    int 21h
    jmp Exit    

Exit:
    mov ah, 4ch
    int 21h    

main endp
;cac chuong trinh con neu co
end main