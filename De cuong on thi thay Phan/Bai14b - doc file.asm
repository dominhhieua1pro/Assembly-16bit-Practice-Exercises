.model small
.stack 100
.data                                  
      tb1 db 'Doc noi dung file ','$'  ; Tao file va noi dung file tu bai 13b
      tb2 db 13,10,'Noi dung file la: $'
      filePointer dw ?
      fileName db 'dmh.txt',0
      buffer db 250 dup ('$'), '$'
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah,9
        lea dx,tb1
        int 21h
        
        mov ah,9
        lea dx,fileName
        int 21h
        
        ;mo va doc file    
        mov ah, 3Dh  ; open file
        lea dx, fileName
        mov al, 2  ; file property
        int 21h
        mov filePointer, ax ; cat the file
        mov ah, 3Fh  ; doc noi dung file vao buffer
        mov bx, filePointer
        lea dx, buffer
        mov cx, 250  ; so byte can doc tu file va luu vao bo nho dem buffer 
        int 21h
        
        mov ah,9
        lea dx,tb2
        int 21h
        
        mov ah, 09h 
        lea dx, buffer
        int 21h     
        
        ;dong file
        CloseFile:
            mov ah,3Eh  ; 3Eh - dong file
            mov bx,filePointer
            int 21h 
        
        ;Exit
        mov ah,4ch
        int 21h
    main endp
end main