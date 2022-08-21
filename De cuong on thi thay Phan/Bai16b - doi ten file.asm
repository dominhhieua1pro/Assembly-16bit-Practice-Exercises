.model small
.stack 100
.data                                  
      tb1 db 'Rename file ','$'  ; Tao file va noi dung file tu bai 13b
      tb2 db 13,10,'File duoc thay doi thanh ','$'
      fileName db 'dmh.txt',0,'$'
      newfileName db 'DoMinhHieuKMA.txt',0 
      filePointer dw ?
      buffer db 251 dup ('$')

.code
    main proc
        mov ax, @data
        mov ds, ax  
        mov es,ax
        
        mov ah,9
        lea dx,tb1
        int 21h
        
        mov ah,9
        lea dx,fileName
        int 21h         
        
        RenameFile:                
            mov ah,56h  ; 56h - rename file
            mov dx,offset fileName 
            mov di,offset newfileName
            int 21h
            
            mov ah,9
            lea dx,tb2
            int 21h  
            
            mov ah,9
            lea dx,newfileName
            int 21h   
               
        ;Exit
        mov ah,4ch
        int 21h
    main endp
end main