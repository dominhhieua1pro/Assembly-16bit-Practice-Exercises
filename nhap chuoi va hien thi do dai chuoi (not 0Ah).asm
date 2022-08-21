.model small
.stack 100
.data
      mang DB 50 dup(?)  
      kt dw ?
      tb1 db 'Nhap chuoi: $'
      tb2 db 10, 13, 'So ki tu: $'
      tb3 db 10, 13, 'Chuoi da nhap la: $' 
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
        mov kt,cx  ; cx luu so ky tu nhap vao, luu vao bien kt phuc vu cho ham Xuat
        mov ax,cx  ; cx luu so ky tu nhap vao, luu vao ax de chia
        mov cx,0  ; xoa cx de luu so chu so
        mov bx,10  ; chia he thap phan
        
        Lap:
            mov dx,0
            div bx  ; al = al / 10, phan nguyen luu vao al, phan du luu vao ah            
            push dx            
            inc cx  ; gia tri cx la so chu so, la so lan lap o vong loop hien thi
            cmp al,0
            je HienThi
            jmp Lap
        HienThi:
            pop dx
            add dx,30h
            mov ah,2
            int 21h
            loop HienThi
        
        lea dx,tb3  
        mov ah,09h
        int 21h
;hien thi da nhap vao        
        mov cx,kt  ; gia tri cx (or cl 8bit) la so ky tu, la so lan lap o vong loop Xuat
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