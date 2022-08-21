.model small
.stack 100
.data
     number db 20,0, 20 dup('$'), '$' 
     tb1 db "Nhap vao so thap phan: $"
     tb2 db 10,13,'Doi ra he co so 16: $'
     tb3 db 10,13,'Doi ra he co so 2: $' 
     x dw ?
     y dw ?

.code
    main proc
        mov ax,@data
        mov ds,ax
        
        ;nhap so thap phan
        mov ah,9
        lea dx, tb1
        int 21h
        
        mov ah,0ah
        lea dx,number
        int 21h 
        
        mov x,0
        mov y,0
        mov bx,10
        xor cx,cx     
        mov cl, [number + 1]
        lea si,number+2       
        Lap1:  
            mov al,[si]
            sub al,30h  
            xor ah,ah  
            mov y,ax  
            mov ax,x  
            mul bx 
            add ax,y 
            mov x,ax
            inc si 
            Loop Lap1
        
        ;convert to hexa
        mov ah,9
        lea dx, tb2
        int 21h
        
        mov ax,0
        mov ax,x  
        xor cx,cx  
        Lap2:
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
            jne Lap2
        Hienthi:
            pop dx
            mov ah,2
            int 21h
            loop Hienthi  
        mov dx,'h'
        mov ah,2 
        int 21h
        
        ;convert to binary
        mov ah,9
        lea dx, tb3
        int 21h
        
        xor bx,bx
        mov bx,x
        mov cx,16    
        Lap3:
            mov dl,30h
            shl bx,1
            adc dl,0
            mov ah,2
            int 21h
            loop Lap3
            mov dl,'b'
            mov ah,2
            int 21h
                    
        ;Exit    
        mov ah,4ch
        int 21h
    main endp       
end main