.model small
.stack 100
.data
tb1 DB 'Nhap 1 chuoi: $'
tb2 DB 13,10,'Nhap ky tu kiem tra: $'
Exist DB 13,10,'Ky tu co ton tai trong chuoi!$'
notExist DB 13,10,'Ky tu khong ton tai trong chuoi!$'
tb3 DB 13,10,'So luong ky tu trong chuoi la: $'
str DB 100 DUP(?)
x DW ?

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ;nhap chuoi
    lea dx, tb1
    mov ah, 9
    int 21h

    lea si, str
    xor cx,cx
    mov ah, 1
inputStr:
    int 21h
    cmp al, 13
    je doneStr
    mov [si], al
    inc si
    inc cx
    jmp inputStr
doneStr:
    mov [si], '$'
    
    ;nhap ky tu
    lea dx, tb2
    mov ah,9
    int 21h
    
    mov ah, 1
    int 21h
    
    ;check
    xor di,di  ; thanh ghi luu so lan same
    lea si, str    
check:    
    mov bl, [si]
    ;mov bl, al
    cmp bl,al
    je tontai
    inc si
    loop check
    
    cmp di,0
    je khongtontai
    jmp hienthi
    
khongtontai:
    lea dx, notExist
    mov ah, 9
    int 21h
    jmp Exit
tontai:
    ;lea dx, exist
    inc di
    inc si
    dec cx
    cmp cx,0
    je hienthi
    jmp check
    
hienthi:
    lea dx,Exist
    mov ah,9
    int 21h
    
    lea dx,tb3
    mov ah,9
    int 21h
    
    mov x,di
    call hienthi_decimal
    
Exit:
    mov ah, 4ch
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
    jmp thoat
hienthi_decimal endp

thoat:
    ret

end main