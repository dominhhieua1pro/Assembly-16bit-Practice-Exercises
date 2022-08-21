.model small
.stack 100h
.data
tb1 db 10,13,"Nhap so a:$"
tb3 db 10,13,"So khong dung! Nhap lai...$"
tb4 db 10,13,"Ket qua $"
tb5 db " la:$"
x dw ?
y dw ?
a dw ?
M dw ? 
.code
main proc
    mov ax,@data
    mov ds,ax
nhap_so_a:    
    mov ah,9
    lea dx,tb1
    int 21h
    call nhap_a
    mov ax,x
    mov a,ax 
    ;Tinh toan
    mov cx,a
    mov ax,1 
    mov bx,1
tinh: 
    mul bx
    add bx,1
    loop tinh
    mov M,ax
    ;Hien thi ket qua
    mov ah,9
    lea dx,tb4
    int 21h
    
    mov ax,a
    mov x,ax
    call hthi_dec
    
    mov ah,2
    mov dx,21h
    int 21h
    
    
    mov ah,9
    lea dx,tb5
    int 21h
    
    mov ax,M
    mov x,ax
    call hthi_dec
    jmp ket_thuc
    
    
main endp 
    ;Nhap so a
nhap_a proc
    mov x,0
    mov y,0
    mov bx,10
nhapa:
    mov ah,1
    int 21h
    cmp al,13
    je thoata   
    cmp al,30h
    jb  nhap_lai_a
    cmp al,37h
    ja  nhap_lai_a
    sub al,30h
    xor ah,ah
    mov y,ax
    mov ax,x
    mul bx
    add ax,y
    cmp al,07h
    ja  nhap_lai_a
    mov x,ax
    jmp nhapa 
nhap_lai_a:
    mov ah,9
    lea dx,tb3
    int 21h
    jmp nhap_so_a
thoata:
    ret
nhap_a endp 
    
    ;>>>>>>>>>
hthi_dec proc
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
hthi_dec endp
ket_thuc:    
end main 