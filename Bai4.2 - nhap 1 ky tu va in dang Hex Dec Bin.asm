.model small
.stack 100
.data
     xuong db 10,13,'$'
     b1 db ?  
     chia16 db 16
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,1
    int 21h
    mov b1,al
    lea dx,xuong
    mov ah,9
    int 21h
    
    mov ax,0
    mov al,b1  ; b1 luu gia tri hexa cua al la ky tu nhap vao
    xor cx,cx  ; tuong duong mov cx,0
Lap1:
    xor dx,dx
    div chia16  ; al chuyen ve decimal roi chia 16
    cmp ah,9
    ja ChuCai
    add ah,30h  
    jmp so
    ChuCai:  
    add ah,37h  
    so:
    mov dl,ah
    push dx
    inc cx
    xor ah,ah
    cmp ax,0
    jne Lap1
    Hienthi:
        pop dx
        mov ah,2
        int 21h
        loop hienthi  
    mov dx,'h'
    mov ah,2 
    int 21h
    
    lea dx,xuong
    mov ah,9
    int 21h 
    
    xor ah,ah
    mov al,b1
    xor cx,cx       ;gan cx = 0 de dem so ky tu so
Lapchia:                                
        xor dx,dx       ;dua dx =0
        mov bx,10
        div bl       ;chia cho ax cho 10 o dang 8 bit thi ah chua so du al chua thuong
        
        add ah,30h      ;bien so trong ah thanh ky tu so
        mov dl,ah       ;dua ah vao dx
        push dx         ;dua dx vao stack
        inc cx          ;them mot chu so la cong them 1
        xor ah,ah       ;xoa ah
        cmp ax,0        ;neu thuong bang 0 thi dung lai
        jne Lapchia
        
Dochienthi:             ;luc nay cx co gia tri la so ky tu
        pop dx          ;lay tung ky tu so in ra
        mov ah,2
        int 21h
        loop Dochienthi  
        
        lea dx,xuong
        mov ah,9
        int 21h 
        xor bx,bx
        mov bl,b1
        mov cx,8
Lap4:
    mov dl,30h
    shl bl,1
    adc dl,0
    mov ah,2
    int 21h
    loop Lap4
    mov dl,'b'
    mov ah,2
    int 21h
    
    mov ah,4Ch
    int 21h
    main endp
end main