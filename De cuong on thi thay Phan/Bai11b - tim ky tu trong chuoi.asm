.model small
.stack 100
.data
    tb1 DB 'Nhap vao 1 chuoi: $'
    tb2 DB 13,10,'Nhap ky tu can tim: $'
    Exist DB 13,10,'Ky tu co ton tai trong chuoi!$'
    notExist DB 13,10,'Ky tu khong ton tai trong chuoi!$'
    tb3 DB 13,10,'Ky tu can tim o index: $'
    string DB 100,0,100 DUP($)
    x DW ?
    index db 0
    lenString db ?
    char db ?

.code
main proc
        mov ax,@data
        mov ds,ax
        
        ;nhap chuoi
        lea dx,tb1
        mov ah,9
        int 21h 
        
        mov ah,0Ah
        lea dx,string        
        int 21h
        
        ;nhap ky tu 
        lea dx,tb2
        mov ah,9
        int 21h
               
        mov ah,1
        int 21h
        mov char,al
        
        ;search
        ;xor di,di  ; thanh ghi luu so lan same
        xor cx,cx
        lea si,string+2
        mov cl,[string+1]            
    search:
        mov lenString,cl    
        mov bl,[si]
        cmp bl,char
        je tontai
        mov dl,index
        inc dl
        mov index,dl
        inc si
        loop search
        
        cmp di,0
        je khongtontai
        jmp Exit
        
    khongtontai:
        lea dx,notExist
        mov ah,9
        int 21h
        jmp Exit
        
    tontai:
        cmp di,0
        jne printIndex
        inc di
        lea dx,Exist
        mov ah,9
        int 21h
        
        lea dx,tb3
        mov ah,9
        int 21h
    printIndex:
        xor ax,ax     
        mov al,index 
        mov x,ax
        call hienthi_decimal
        mov dl,' '
        mov ah,2
        int 21h                    
        
        mov dl,index
        inc dl
        mov index,dl
        
        ;lap search tiep                    
        inc si
        mov cl,lenString
        loop search
            
    Exit:
        mov ah,4ch
        int 21h
main endp

hienthi_decimal proc
    mov bx,10
    mov ax,x
    mov cx,0
chia:
    mov dx,0
    div bx
    inc cx
    push dx
    cmp al,0
    je ht
    jmp chia
ht:
    pop dx 
    add dl,30h
    mov ah,2
    int 21h
    dec cx
    cmp cx,0
    jne ht
    ret
hienthi_decimal endp

end main