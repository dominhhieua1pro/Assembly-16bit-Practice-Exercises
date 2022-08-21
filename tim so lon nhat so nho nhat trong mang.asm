.model small
.stack 100
.data
tb1 db "So lon nhat la: $"
tb2 db 13,10,"So nho nhat la: $"
mang db 5,4,6,7,3,2,8,0,1,9
.code
main proc
    mov ax,@data
    mov ds,ax
;tim so lon nhat    
    lea dx,tb1
    mov ah,9
    int 21h
    
    lea bx,mang  ; gan dia chi cua mang cho bx (la dia chi cua phan tu dau tien cua mang)
    mov cx,9   ; so phan tu con lai cua mang (tu so 4) =  so lan lap
    mov dl,[bx]  ; gan dl = gia tri cua phan tu dau tien cua mang (so 5)
lap_max:
    inc bx
    cmp dl,[bx]
    jg continue_max
    mov dl,[bx]
continue_max:
    loop lap_max
    
    ;hien thi
    add dl,30h
    mov ah,2
    int 21h

;tim so nho nhat    
    lea dx,tb2
    mov ah,9
    int 21h
    
    lea bx,mang 
    mov cx,9  
    mov dl,[bx]
lap_min:
    inc bx
    cmp dl,[bx]
    jl continue_min
    mov dl,[bx]
continue_min:
    loop lap_min
    
    ;hien thi
    add dl,30h
    mov ah,2
    int 21h
    
    ;exit
    mov ah,4ch
    int 21h
main endp
end main