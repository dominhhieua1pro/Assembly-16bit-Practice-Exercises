.model small
.stack 100
.data
    string DB 100,0,100 dup($)  
    tb1 db 'Nhap vao 1 chuoi: $'
    tb2 db 10, 13, 'So ki tu cua chuoi la: $'
    x dw ?
     
.code
main proc   
    mov ax,@data
    mov ds,ax
        
    ;nhap chuoi 
    lea dx,tb1
    mov ah,9
    int 21h
        
    lea dx,string
    mov ah,0Ah
    int 21h
    
    lea dx,tb2
    mov ah,9
    int 21h
    
    ;hien thi length
    xor ax,ax
    mov al,[string+1]
    mov x,ax
    call hienthi_decimal
    
    ;Exit
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