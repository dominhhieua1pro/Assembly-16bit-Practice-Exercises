.model small
.stack 100
.data
    tb1 db 13,10,"Nhap vao ten sinh vien: $"
    tb2 db "Do Minh Hieu", 13, '$'
    tb3 db 13,10,"Ma sinh vien la: AT160127 $"
    tb4 db 13,10,"Ten sinh vien khong dung! $"
    tenSV db 100,0,100 dup('$')

.code
main proc
    mov ax,@data
    mov ds,ax
    
    NhapTen: 
        lea dx,tb1  
        mov ah,09h
        int 21h
            
        lea dx,tenSV
        mov ah,0Ah
        int 21h
    
    SoSanh:
        xor cx,cx
        lea si,tenSV+2 
        mov cl,[tenSV+1]
        lea di,tb2
           
        Lap:
            xor ax,ax
            mov ax,[si]
            cmp ax,[di]
            jne KhongGiong
            inc si
            inc di
            loop Lap
            lea dx,tb3
            mov ah,9
            int 21h
            jmp KetThuc
            
            KhongGiong:
                lea dx,tb4
                mov ah,9
                int 21h
                jmp NhapTen
                   
    KetThuc:
        mov ah,4ch
        int 21h
main endp
end main