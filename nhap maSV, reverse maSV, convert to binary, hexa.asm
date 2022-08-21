.model small
.stack 100
.data
     mang db 20,0, 20 dup('$'), '$' 
     tb1 db "Nhap vao ma SV: $"
     tb2 db 10,13,'Ma SV la: $' 
     tb3 db 10,13,'Ma SV dao nguoc la: $'
     tb4 db 10,13,'3 so cuoi ma SV la: $'
     tb5 db 10,13,'Doi 3 so cuoi ma SV ra he co so 2: $'
     tb6 db 10,13,'Doi 3 so cuoi ma SV ra he co so 16: $' 
     x dw ?
     y dw ?
     3socuoi dw ?
.code
    main proc
        mov ax,@data
        mov ds,ax
        
        ;nhap ma sv
        mov ah,9
        lea dx, tb1
        int 21h
        
        mov ah,0ah
        lea dx,mang
        int 21h
        
        ;hien thi ma sv
        lea dx,tb2
        mov ah,9
        int 21h
        lea dx,mang+2
        int 21h
        
        ;hien thi dao nguoc
        lea dx,tb3
        mov ah,9
        int 21h
        
        xor cx,cx
        mov cl,[mang + 1]
        lea si, mang + 2
        Lap1:
            push [si]
            inc si 
            loop Lap1
            
        mov cl, [mang + 1]
        Lap2:
            pop dx
            mov ah,2
            int 21h
            Loop Lap2
        
        ;lay ra 3 so cuoi ma sv
        mov x,0
        mov y,0
        mov bx,10
        xor cx,cx     
        mov cl, [mang + 1]
        lea si, mang
        add si, cx
        sub si, 1
        
        mov cx, 03h
        Lap3:  
            mov al,[si]
            sub al,30h  
            xor ah,ah  
            mov y,ax  
            mov ax,x  
            mul bx 
            add ax,y 
            mov x,ax
            inc si 
            Loop Lap3
        
        ;in 3 so cuoi ma sv
        lea dx,tb4
        mov ah,9
        int 21h
        call hienthi_decimal
        
        ;convert to binary
        mov ah,9
        lea dx, tb5
        int 21h
        
        xor bx,bx
        mov bx,x
        mov cx,16    
        Lap4:
            mov dl,30h
            shl bx,1
            adc dl,0
            mov ah,2
            int 21h
            loop Lap4
            mov dl,'b'
            mov ah,2
            int 21h
        
        ;convert to hexa
        mov ah,9
        lea dx, tb6
        int 21h
        
        mov ax,0
        mov ax,x  
        xor cx,cx  
        Lap5:
            xor dx,dx
            mov bl,16
            div bl 
            cmp ah,9
            ja ChuCai
            add ah,30h  
            jmp So
        ChuCai:  
            add ah,37h  
        So:
            mov dl,ah
            push dx
            inc cx
            xor ah,ah
            cmp ax,0
            jne Lap5
        Hienthi:
            pop dx
            mov ah,2
            int 21h
            loop hienthi  
        mov dx,'h'
        mov ah,2 
        int 21h
            
        ;Exit    
        mov ah,4ch
        int 21h
    main endp
    
hienthi_decimal proc
    mov bx,10
    mov ax,x
    mov cx,0
chia:
    mov dx,0
    div bx
    inc cx
    push dx
    cmp al,0
    je ht
    jmp chia
ht:
    pop dx 
    add dl,30h
    mov ah,2
    int 21h
    dec cx
    cmp cx,0
    jne ht
    jmp thoat
hienthi_decimal endp

thoat:
    ret    
    
end main