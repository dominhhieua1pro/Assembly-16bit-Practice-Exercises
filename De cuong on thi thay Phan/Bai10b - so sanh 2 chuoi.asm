.model small
.stack 100
.data
tb1 db "Nhap chuoi ky tu 1: $"
tb2 db 13,10,"Nhap chuoi ky tu 2: $"
tb3 db 13,10,"2 chuoi ky tu nhap vao giong nhau! $"
tb4 db 13,10,"2 chuoi ky tu nhap vao khac nhau! $"
str1 db 100,0,100 dup('$')
str2 db 100,0,100 dup('$')
.code
main proc
    mov ax,@data
    mov ds,ax
    
    ;nhap chuoi 1  
        lea dx,tb1  
        mov ah,09h
        int 21h
            
        lea dx,str1
        mov ah,0Ah
        int 21h
    
    ;nhap chuoi 2            
        lea dx,tb2  
        mov ah,09h
        int 21h 
                
        lea dx,str2 
        mov ah,0Ah
        int 21h
    
    Compare: 
    xor cx,cx
    lea si,str1+2
    lea di,str2+2
    mov cl,[str1 + 1]
       
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