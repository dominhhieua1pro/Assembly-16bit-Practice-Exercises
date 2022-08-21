.model small
.stack 100
.data
tb1 db 10,13,"Nhap MSV: $"
tb2 db "AT160350",13,"$"
tb3 db 13,10,"DINH THI THU $"
tb4 db 13,10,"sai msv$"
str1 db 100,0,100 dup('$')
.code
main proc
    mov ax,@data
    mov ds,ax
    
    ;nhap chuoi 1    
    nhap:
        lea dx,tb1  
        mov ah,09h
        int 21h    
        lea dx,str1 
        mov ah,10
        int 21h
        xor cx,cx 
        
  
    
    check:
    lea si,str1+2
    mov cl,[str1+1]
    lea di,tb2     
    
    Lap1:
            cmp [si],'a'
            jl Next
            cmp [si],'z'
            jg Next
            sub [si],20h 
            
            Next:
                inc si
                loop Lap1   
    lea si,str1+2
    mov cl,[str1+1]
    lea di,tb2     
    
       
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
            jmp nhap
                   
    Exit:
        mov ah,4ch
        int 21h
main endp
end main