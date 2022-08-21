.model small
.stack 50
.data   
        tb1 db "Tao file KTMTL03.txt", '$'
        tb2 db 13,10,"Tao file thanh cong!", '$'
        tb3 db 13,10,"Sua file KTMTL03.txt", '$'
        tb4 db 13,10,"Nhap noi dung them vao file: ", '$'
        tb5 db 13,10,"Sua file thanh cong!", '$'
        tb6 db 13,10,"Noi dung trong file KTMTL03.txt la: ", '$'
        tb7 db 13,10,"Xoa file KTMTL03.txt", '$'
        tb8 db 13,10,"File da duoc xoa!", '$'
        filePointer dw ?  ; the file
        fileName db 'KTMTL03.txt',0
        buffer db 251 dup ('$')
                
.code
    main proc 
        mov ax, @data
        mov ds, ax
        
        ;tao file
        mov ah,9
        lea dx,tb1
        int 21h
        
        mov cx,0  ; thuoc tinh tap tin
        lea dx,fileName
        mov ah,3Ch  ; 3Ch - tao file
        int 21h  
        
        mov filePointer, ax  ; cat the file
        
        mov ah,9
        lea dx,tb2
        int 21h
        
        ;sua file
        mov ah,9
        lea dx,tb3
        int 21h
        
        mov ah,9
        lea dx,tb4
        int 21h
        
        WriteFile: 
        xor dx,dx
        mov ah,1
        int 21h
        cmp al,13
        je CloseFile
        mov buffer,al
        lea dx,buffer
        mov bx,filePointer
        mov cx,1
        mov ah,40h  ; 40h - ghi file
        int 21h
        jmp WriteFile
        
        ;dong file
        CloseFile:              
        mov ah,3Eh  ; 3Eh - dong file
        mov bx,filePointer
        int 21h
        jmp ReadFile        
        
        ;doc file
        ReadFile:
        mov ah,9
        lea dx,tb5
        int 21h
            
        mov ah, 3Dh ; mo tap tin da co
        lea dx, fileName
        mov al, 2 ; thuoc tinh tap tin
        int 21h
        ;mov filePointer, ax ; cat the file
        mov ah, 3Fh ; doc noi dung file vao vung dem
        mov bx, filePointer
        lea dx, buffer
        mov cx, 250 ; so byte can doc tu file da mo
        int 21h
        
        mov ah,9
        lea dx,tb6
        int 21h
        
        mov ah, 09h ; in noi dung cua file ra man hinh
        lea dx, buffer
        int 21h
        ;mov ah,08h ; dung man hinh de xem ket qua
        ;int 21h
        
        ;xoa file
        DeleteFile:                 
            mov ah,9
            lea dx,tb7
            int 21h
            
            mov ah,41h  ; 41h - xoa file
            lea dx,fileName
            int 21h
            
            mov ah,9
            lea dx,tb8
            int 21h                    
        
        ;Exit            
        mov ah,4Ch
        int 21h
    main endp
end main
