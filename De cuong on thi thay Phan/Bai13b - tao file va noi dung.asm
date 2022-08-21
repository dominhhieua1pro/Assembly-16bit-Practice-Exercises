.model small
.stack 100
.data
    fileName db 30 dup(?),'$'
    content db 30 dup('$')
    tb1 db 'Nhap ten file can tao moi: ', '$'  ; mac dinh file luu o C:\EMU8086\MyBuild\
    tb2 db 10,13,'Nhap noi dung file: $'
    tb3 db 10,13,'Done save file! $'
    filePointer dw ?  
    buffer db 251 dup ('$')  ; buffer la bo dem ,vung luu tru du lieu tam thoi trong bo nho RAM  
 
.code
    main proc
        mov ax,@data
        mov ds,ax
        
    ;create new file         
        lea dx, tb1
        mov ah,9
        int 21h 
        
        ;nhap ten file               
        lea si,fileName
        xor cx,cx 
        LapNhap:        
            mov ah,1
            int 21h 
            cmp al,0Dh
            je EndString
            mov [si], al
            inc si
            inc cx
            jmp LapNhap        
        EndString:
            mov cx,0  
            lea dx,fileName
            mov ah,3Ch  ;tao file
            int 21h
                     
    ;ghi noi dung
        mov filePointer, ax  ; cat the file      
        mov ah,9
        lea dx,tb2
        int 21h
        
        lea si,content
        xor cx,cx 
        LapNhapKyTu:        
            mov ah,1
            int 21h 
            cmp al,0Dh
            je EndStr
            mov [si], al
            inc si
            inc cx
            jmp LapNhapKyTu        
        EndStr:
            lea si,content
            jmp WriteFile
                   
    ;ghi va luu file  
        WriteFile: 
            xor dx,dx 
            cmp [si], '$'
            je CloseFile
            mov al,[si]
            mov buffer,al
            lea dx,buffer
            mov bx,filePointer
            mov cx,1
            mov ah,40h  ; 40h - ghi file
            int 21h
            inc si
            jmp WriteFile
                               
    ;dong file
        CloseFile:
            mov ah,3Eh  ; 3Eh - dong file
            mov bx,filePointer
            int 21h 
            
            lea dx, tb3
            mov ah,9
            int 21h       
            
    ;Exit
        mov ah,4Ch
        int 21h
    main endp  
end main