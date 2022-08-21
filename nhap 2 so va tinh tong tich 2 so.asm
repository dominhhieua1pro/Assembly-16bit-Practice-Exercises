.model small
.stack 100
.data
tb1 db 10,13,"Nhap thap phan thu nhat (0-255): $"
tb2 db 10,13,"Nhap thap phan thu hai (0-255): $"
tb3 db 10,13,"Tong hai so la: $"
tb4 db 10,13,"Tich hai so la: $"
x dw ?
y dw ?
z dw ?
t dw ?
.code
main proc
    mov ax,@data
    mov ds,ax
    ;nhap
    mov ah,9
    lea dx,tb1
    int 21h
    call nhap_decimal
    mov ax,x
    mov z,ax
    
    mov ah,9
    lea dx,tb2
    int 21h
    call nhap_decimal
    mov ax,x
    mov t,ax
    
    ;tinh tong
    mov ah,9
    lea dx,tb3
    int 21h
    mov ax,z
    add ax,t
    mov x,ax
    call hienthi_decimal
    
    ;tinh tich
    mov ah,9
    lea dx,tb4
    int 21h
    mov ax,z
    mul t
    mov x,ax
    call hienthi_decimal
    
    ;exit
    mov ah,4ch
    int 21h
    
main endp

nhap_decimal proc
    mov x,0
    mov y,0
    mov bx,10
nhap:
    mov ah,1
    int 21h
    cmp al,13
    je thoat 
    sub al,30h
    xor ah,ah
    mov y,ax
    mov ax,x
    mul bx
    add ax,y
    mov x,ax
    jmp nhap
nhap_decimal endp

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