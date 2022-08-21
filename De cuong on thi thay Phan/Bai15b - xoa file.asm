.model small
.stack 100
.data                                  
      tb1 db 'Xoa file ','$'  ; Tao file va noi dung file tu bai 13b
      tb2 db 13,10,'File deleted! $'
      filePointer dw ?
      fileName db 'dmh.txt',0
      buffer db 251 dup ('$')
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
        
        ;mo lai file, dong file roi moi xoa duoc file
        mov ah, 3Dh  ; open file
        lea dx, fileName
        mov al, 2 
        int 21h
        mov filePointer, ax 
        
        CloseFile:
            mov ah,3Eh  ; 3Eh - dong file
            mov bx,filePointer
            int 21h
        
        DeleteFile:                
            mov ah,41h  ; 41h - xoa file
            lea dx,fileName
            int 21h
            
            mov ah,9
            lea dx,tb2
            int 21h     
               
        ;Exit
        mov ah,4ch
        int 21h
    main endp
end main