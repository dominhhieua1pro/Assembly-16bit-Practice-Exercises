.model small
.stack 100
.data
     string db 50,0, 50 dup(?) 
     tb1 db "Nhap vao chuoi ky tu: $" 
     tb2 db 10,13,'Chuoi ky tu dao nguoc la: $' 
     
.code
    main proc
        mov ax,@data
        mov ds,ax
        
        ;nhap chuoi
        mov ah,9
        lea dx, tb1
        int 21h
        
        mov ah,0ah
        lea dx,string
        int 21h
        
        ;reverse
        lea dx, tb2
        mov ah,9
        int 21h
        
        xor cx,cx
        mov cl,[string + 1]
        lea si,string + 2
        Lap:
            push [si]
            inc si 
            loop Lap
            
        mov cl,[string + 1]
        Lap2:
            pop dx
            mov ah,2
            int 21h
            Loop Lap2 
        
        ;Exit
        mov ah,4ch
        int 21h
    main endp
end main