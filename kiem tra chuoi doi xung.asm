.model small
.stack 100
.data
tb1 db "Nhap chuoi kiem tra doi xung: $"
tb2 db 13,10,"Chuoi da nhap doi xung! $"
tb3 db 13,10,"Chuoi da nhap khong doi xung! $"
str db 100,?,101 dup('$')
.code
main proc
    mov ax,@data
    mov ds,ax
    
    ;nhap chuoi
    mov ah,9
    lea dx,tb1
    int 21h
    
    mov ah,0Ah
    lea dx,str
    int 21h
    
    ;check
    xor cx,cx
    lea si,str+2
    mov cl,[str+1]
    while:
        xor dx,dx
        mov dl,[si]
        push dx
        inc si
        loop while
       
    check:
        xor dx,dx
        xor ax,ax
        xor cx,cx
        lea si,str+2
        mov cl,[str+1]
        lap:
            pop dx
            mov al,[si]
            cmp ax,dx
            jne khongdoixung
            inc si
            loop lap
            
        doixung:
            mov ah,9
            lea dx,tb2
            int 21h
            jmp exit
            
        khongdoixung:
            mov ah,9
            lea dx,tb3
            int 21h
            jmp exit  
     
    exit:
        mov ah,4ch
        int 21h
main endp
end main