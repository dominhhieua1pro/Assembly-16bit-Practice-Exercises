.model small
.stack 100
.data
    fileName db 30 dup(?),'$'
    str db 30 dup(?),'$'
    tb1 db 'Tao file moi','$'
    tb2 db 10,13,'Nhap ten file can tao: ', '$'
    tb3 db 10,13,'Nhap chuoi ky tu thuong: $'
    tb4 db 10,13,'Done save file! $'

    CRLF db 13,10, '$'
    filePointer dw ?  
    buffer db 251 dup ('$')  
 
.code
    main proc
        mov ax,@data
        mov ds,ax
        
;create new file 
        lea dx, tb1
        mov ah,9
        int 21h
        
        lea dx, tb2
        int 21h 
        
        ;nhap ten        
        lea si,fileName
        call NhapChuoi
        mov cx,0  
        lea dx,fileName
        mov ah,3Ch  ;tao file
        int 21h         

;nhap ky tu
        mov filePointer, ax  ; the file      
        mov ah,9
        lea dx,tb3
        int 21h
        lea si,str
        call NhapChuoi
        
;uppercase ky tu dau tien cua moi tu
        lea si,str
        cmp [si],'a'  ; neu ky tu dau la in hoa thi bo qua 
        jl LapKyTu
        sub [si],20h  ; neu la in thuong thi chuyen sang in hoa
            
        LapKyTu:
            inc si  ; chuyen sang ky tu tiep theo
            cmp [si],'$'  ; neu ky tu = '$' thi ket thuc
            je EndStr
            cmp [si],20h   ; neu ky tu la space thi kiem tra ky tu tiep theo
            je Space 
            jmp LapKyTu    
            
            Space:
                cmp [si+1],'$'  ; neu ky tu tiep theo = '$' thi cung ket thuc 
                je EndStr
                cmp [si+1],'a'   ; neu ky tu la in hoa roi thi bo qua
                jl LapKyTu
                sub [si+1],20h   ; neu ky tu la in thuong thi chuyen sang in hoa
                jmp LapKyTu    
            
        EndStr:
            jmp SaveFile
            
;ghi va luu file
        SaveFile:     
            lea si,str    
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
            lea dx, tb4
            mov ah,9
            int 21h
                          
            mov ah,3Eh  ; 3Eh - dong file
            mov bx,filePointer
            int 21h        
            
;Exit
        mov ah,4Ch
        int 21h
    main endp
    
    NhapChuoi proc    
        xor cx,cx 
        LapNhapKyTu:        
            mov ah,1
            int 21h 
            cmp al,0Dh
            je EndString
            mov [si], al
            inc si
            inc cx
            jmp LapNhapKyTu        
        EndString:
            ret
    NhapChuoi endp
end main