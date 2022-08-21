.model small
.stack 100
.data
    mang DB 100 dup(?),'$'  
    tb1 db 'Nhap chuoi: $'
    tb2 db 10, 13, 'Chuoi da nhap la: $' 
.code
    main proc
        mov ax,@data
        mov ds,ax
         
        lea dx, tb1
        mov ah,9
        int 21h
        
        ;nhap mang
        lea si,mang
        xor cx,cx 
    LapNhapKyTu:        
        mov ah,1
        int 21h 
        cmp al,0Dh
        je EndString
        mov [si], al
        inc si
        inc cx
        jmp LapNhapKyTu        
    EndString:  
        lea dx,tb2  
        mov ah,09h
        int 21h
        
        lea dx,mang
        mov ah,9
        int 21h
        
    ;Exit
        mov ah,4Ch
        int 21h
    main endp
end main