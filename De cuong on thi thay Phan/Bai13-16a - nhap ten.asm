.model small
.stack 100
.data
    tb1 db "Nhap ten cua ban: $"
    tb2 db "Do Minh Hieu", 13, '$'
    tb3 db 13,10,"Ten dung! Ma SV cua ban la: AT160127 $"
    tb4 db 13,10,"Ban nhap sai ten! $"
    maSV db 100,0,100 dup('$')

.code
main proc
    mov ax,@data
    mov ds,ax
    
    ;nhap ma SV  
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