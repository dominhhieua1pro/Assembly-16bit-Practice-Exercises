.model small
.stack 100
.data
tb1 db "Nhap so thu nhat: $"
tb2 db 13,10,"Nhap so thu hai: $"
tb3 db 13,10,"Uoc chung lon nhat cua 2 so la: $"
tb4 db 13,10,"Boi chung nho nhat cua 2 so la: $"
x dw ?
y dw ?
z dw ?
t dw ?
k dw ?
 
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,tb1
    int 21h
    call nhap_decimal
    mov ax,x
    mov z,ax  ; z luu so thu nhat
    
    mov ah,9
    lea dx,tb2
    int 21h
    call nhap_decimal
    mov ax,x
    mov t,ax  ; t luu so thu nhat
    
    ;UCLN
    mov ah,9
    lea dx,tb3
    int 21h
    
    mov ax,z
    mov bx,t
    while:
        cmp ax,bx
        je ucln
        jl less
        sub ax,bx
        jmp while
        
        less:
            sub bx,ax
            jmp while
            
    ucln:
        mov x,ax
        call hienthi_decimal
    
    ;BCNN
    mov ah,9
    lea dx,tb4
    int 21h
    
    mov ax,x  ; x dang la UCLN
    mov k,ax  ; luu UCLN vao k
    mov ax,z
    mov bx,t
    mul bx
    div k     ; tich 2 so / UCLN = BCNN
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