.model small
.stack 100
.data
    tb1 db 13,10,"Nhap ma SV cua ban: $"
    tb2 db "AT160127",13,'$'
    tb3 db 13,10,"Ma SV dung! Ten cua ban la: Do Minh Hieu $"
    tb4 db 13,10,"Ban nhap sai ma SV! $"
    maSV db 100,0,100 dup('$')

.code
main proc
    mov ax,@data
    mov ds,ax
    
    nhapMaSV:  
        lea dx,tb1  
        mov ah,09h
        int 21h
            
        lea dx,maSV
        mov ah,0Ah
        int 21h
    
    Compare:
        xor cx,cx
        lea si,maSV+2 
        mov cl,[maSV+1]
        lea di,tb2
           
        lap:
            xor ax,ax
            mov ax,[di]
            cmp ax,[si]
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
                jmp nhapMaSV
                   
    Exit:
        mov ah,4ch
        int 21h
main endp
end main