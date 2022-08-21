.model small
.stack 100
.data
      mang DB 50 dup(?)  
      kt Db ?
      tb1 db 'Nhap chuoi: $'
      tb2 db 10, 13, 'So ki tu: $'
      tb3 db 10, 13, 'Chuoi da nhap la: $' 
      chia db 10
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
LapNhap:        
        mov ah,1
        int 21h 
        cmp al,0Dh
        je Xuong
        mov [si], al
        inc si
        inc cx
        jmp LapNhap
;xuong dong        
Xuong:  
        lea dx, tb2  
        mov ah,09h
        int 21h
;hien thi so ky tu        
        mov kt,cl
        mov al,cl
        mov ah,0
        xor cx,cx
        Lap:
            xor dx,dx
            div chia  ; al = al / 10, phan nguyen luu vao al, phan du luu vao ah
            
            add ah,30h
            mov dl,ah
            push dx
            inc cx  ; gia tri cx la so chu so, la so lan lap o vong loop hien thi
            xor ah,ah
            cmp ax,0
            jne Lap
        HienThi:
            pop dx
            mov ah,2
            int 21h
            loop HienThi
        
        lea dx,tb3  
        mov ah,09h
        int 21h
;hien thi da nhap vao        
        mov cl,kt  ; gia tri cx (or cl 8bit) la so ky tu, la so lan lap o vong loop Xuat
        lea si,mang
        Xuat:
            mov dl,[si]
            mov ah,2
            int 21h
            inc si
            loop Xuat  
;Exit            
        mov ah,4Ch
        int 21h
    
    main endp
end main