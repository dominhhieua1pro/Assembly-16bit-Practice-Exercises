.model small
.stack 50
.data
        mang db 50,0, 50 dup('$')
        tb1 db 'Nhap vao chuoi ky tu: $'
        tb2 db 10,13,'Chuoi ky tu in thuong: $'
        tb3 db 10,13,'Chuoi ky tu in hoa: $'
.code
    main proc
        mov ax,@data
        mov ds,ax
        ;nhap chuoi
        lea dx, tb1
        mov ah,9
        int 21h
                 
        mov ah,0Ah
        lea dx,mang
        int 21h 
        ;in thuong 
        lea dx,tb2
        mov ah,9
        int 21h        
        
        xor cx,cx
        lea si,mang+ 2
        mov cl, [mang + 1]  ; so lan lap vong loop, la so luong ky tu (gan cho thanh ghi cl la gan do dai cua chuoi) 
        Lap1:
            cmp [si],'A'
            jl Boqua
            cmp [si],'Z'
            jg Boqua
            add [si],20h
            
            Boqua: 
                inc si
            loop lap1        
        
        call xuat
        ;in hoa  
        lea dx,tb3
        mov ah,9
        int 21h
        
        xor cx,cx 
        lea si,mang + 2
        mov cl,[mang + 1]
        Lap2:
            cmp [si],'a'
            jl Boqua2
            cmp [si],'z'
            jg Boqua2
            sub [si],20h 
            
            Boqua2:
                inc si
            loop Lap2
        
        call xuat
        ;exit
        mov ah,4ch
        int 21h          
    main endp 
    
    xuat PROC
        mov cl,[mang + 1]
        lea si,mang + 2
        lap:
        mov dl,[si]
        mov ah,2
        int 21h
        inc si
        loop lap
        ret 
    xuat endp
end main