.model small
.stack 100h
.data
tb1 db "Nhap vao n: $"  ;emu8086 tinh toan chinh xac toi da 8!
tb2 db 10,13,"Ket qua n! = $"
x dw ?
y dw ?
gt dw ?
 
.code
    main proc
        mov ax,@data            
        mov ds,ax
    nhap_so_n:    
        mov ah,9
        lea dx,tb1
        int 21h
        call nhap_n
         
        ;Tinh toan giai thua
        mov cx,x
        mov ax,1 
        mov bx,1
    tinhgt: 
        mul bx
        inc bx
        loop tinhgt
        mov gt,ax 
        
        ;Hien thi ket qua
        mov ah,9
        lea dx,tb2
        int 21h
        
        mov ax,gt
        mov x,ax
        call hthi_dec
        
        ;Exit
        mov ah,4ch
        int 21h    
        
    main endp

;Nhap so n
nhap_n proc
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
thoat:
    ret
nhap_n endp 
    
;hien thi so thap phan
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
    je hthi
    jmp chia
hthi:
    pop dx 
    add dl,30h
    mov ah,2
    int 21h
    dec cx
    cmp cx,0
    jne hthi
    ret
hthi_dec endp
    
end main 