.model small
.stack 50
.data
    string db 50,0, 50 dup('$')
    tb1 db 'Nhap vao chuoi ky tu: $'
    tb2 db 10,13,'Chuoi ky tu in thuong: $'
.code
    main proc
        mov ax,@data
        mov ds,ax
        
        ;nhap chuoi
        lea dx, tb1
        mov ah,9
        int 21h
                 
        mov ah,0Ah
        lea dx,string
        int 21h  
        
        ;in hoa  
        lea dx,tb2
        mov ah,9
        int 21h
        
        xor cx,cx 
        lea si,string + 2
        mov cl,[string + 1]
        Lap:
            cmp [si],'A'
            jl Next
            cmp [si],'Z'
            jg Next
            add [si],20h 
            
            Next:
                inc si
                loop Lap       
                
        ;hien thi
        lea dx,string + 2
        mov ah,9
        int 21h  
        
        ;exit
        mov ah,4ch
        int 21h          
    main endp 

end main