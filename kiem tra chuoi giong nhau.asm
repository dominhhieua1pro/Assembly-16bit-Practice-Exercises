.model small
.stack 100
.data
tb1 db "Nhap chuoi 1: $"
tb2 db 13,10,"Nhap chuoi 2: $"
tb3 db 13,10,"2 chuoi nhap vao giong nhau! $"
tb4 db 13,10,"2 chuoi nhap vao khac nhau! $"
str1 db 100 dup('$')
str2 db 100 dup('$')
.code
main proc
    mov ax,@data
    mov ds,ax
    
    ;nhap chuoi 1  
        lea dx,tb1  
        mov ah,09h
        int 21h    
        lea si,str1
        xor cx,cx 
    Nhapstr1:        
        mov ah,1
        int 21h 
        cmp al,0Dh
        je Nhap2
        mov [si], al
        inc si
        inc cx
        jmp Nhapstr1
    
    ;nhap chuoi 2            
    Nhap2: 
        lea dx,tb2  
        mov ah,09h
        int 21h         
        lea di,str2 
    Nhapstr2:        
        mov ah,1
        int 21h 
        cmp al,0Dh
        je check
        mov [di], al
        inc di
        jmp Nhapstr2
    
    check:
    lea si,str1
    lea di,str2
       
    lap:
        xor ax,ax
        mov ax,[si]
        cmp ax,[di]
        jne notsame
        inc si
        inc di
        loop lap
        lea dx,tb3
        mov ah,9
        int 21h
        jmp Exit
        
        notsame:
            lea dx,tb4
            mov ah,9
            int 21h
            jmp Exit
                   
    Exit:
        mov ah,4ch
        int 21h
main endp
end main