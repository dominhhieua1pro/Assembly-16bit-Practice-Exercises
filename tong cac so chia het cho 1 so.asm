.model small
.stack 100
.data
tb1 db "Tong cac so chia het cho 7 la: $"
mang db 1,3,7,9,0,14,21,23,45,35,40
x dw ?
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,tb1
    int 21h
    
    mov x,0
    mov cx,11
    lea si,mang
    mov bx,7  ; sua 7 thanh gia tri khac
lap:
    mov dx,0
    mov ax,[si]  ; gan gia tri cua phan tu dau tien cua mang vao thanh ghi ax thi phan tu hien tai luu vao AL, phan tu ke tiep luu vao AH
    xor ah,ah  ; nen can phai xoa thanh ghi AH de chi lay AL la gia tri phan tu hien tai
    div bx
    cmp dx,0
    jne continue
    ;sum
    mov ax,[si]
    xor ah,ah
    add x,ax
continue:
    inc si
    loop lap
    
    ;display
    call hienthi_decimal
    
    ;exit
    mov ah,4ch
    int 21h
    
main endp

hienthi_decimal proc    
    mov ax,x
    mov bx,10
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
