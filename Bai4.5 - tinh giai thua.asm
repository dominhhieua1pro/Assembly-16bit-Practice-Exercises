.model small
.stack 50
.data
    muoi dw 10
    xuong db 10,13,'$' 
    tb1 db 'Nhap so nguyen <=8 & >=0: $'
    tb2 db 13,10,'Ket qua ', '$'
    tb3 db '! la: $'
    a db ?
.code
    main proc
        mov ax,@data
        mov ds,ax   
        
        lea dx, tb1
        mov ah,9
        int 21h
        
        mov ah,01h
        int 21h  
        
        mov a,al
        
        mov ah,09h
        lea dx,tb2
        int 21h
        
        mov ah,02h
        mov dl,a
        int 21h
        
        mov ah,09h
        lea dx,tb3
        int 21h
        
        sub a,30h
        xor cx,cx 
        mov cl,a
               
        mov ax,1
        mov bx,1
        Giaithua:
            mul bx 
            inc bx
            cmp bx,cx
            jle giaithua 
        xor cx,cx
        Lappush:
            xor dx,dx
            mov bx,10
            div bx
            add dx,30h
            push dx
            inc cx
            cmp ax,0
            jne Lappush
        Hienthi:
            pop dx
            mov ah,2
            int 21h
            Loop HienThi
                
        mov ah,4Ch
        int 21h 
    main endp
end main 

; Kha nang cua 8086 tinh duoc lon nhat la 8! do 9! vuot qua 16bit