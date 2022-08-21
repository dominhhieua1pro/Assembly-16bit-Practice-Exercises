.model small
.stack 100
.data
tb1 db "Nhap so: $"
tb2 db 13,10,"So vua nhap la: $"
x dw ?  ;16bit
y dw ?  ;16bit

.code
main proc
    mov ax, @data
    mov ds, ax
    ;Nhap so
    mov ah,9
    lea dx,tb1
    int 21h
    call nhapso
    ;Hien thi so
    mov ah,9
    lea dx,tb2
    int 21h
    call hienthi
    ;Ket thuc
    mov ah,4ch
    int 21h     
main endp
;ham con input
nhapso proc
    mov x,0
    mov y,0
    mov bx,10  ;thay bx = 2 or 8 de thuc hien in so trong he nhi phan, bat phan (thay 2 vi tri bx)
nhap:
    mov ah,1
    int 21h  ;ky tu nhap vao duoc luu vao thanh ghi al (gia su nhap 5 => al = 35h)
    cmp al,13  ;nhap nhieu ky tu va so sanh voi ky tu enter
    je exit  ;neu nhap ky tu enter thi return ve main va thuc hien dong tiep theo sau lenh call nhapso, neu je # 13 thi thuc hien lenh tiep ben duoi
    sub al,30h  ;gia tri hexa cua al tru 30h = gia tri so vua nhap (5)
    xor ah,ah  ;xoa thanh ghi ah ve 00h de lay gia tri thanh ghi ax 16bit = 0005h luu vao y vi y la 16bit
    mov y,ax  ;luu y lam hang don vi
    mov ax,x  ; chuyen x vao ax de chuan bi phep nhan
    mul bx  ;ax = ax * bx = ax * 10 lam hang chuc
    add ax,y  ;ax = ax + y = hang chuc + hang don vi 
    mov x,ax  ;luu ax vao bien x
    jmp nhap  ;quay lai ham nhap
exit:
    ret
nhapso endp
;ham con output
hienthi proc
    mov bx,10
    mov ax,x  ;voi x la so nhap vao, chuyen x vao ax de chuan bi phep chia
    mov cx,0  ;bien cx dem so lan chia
chia:
    mov dx,0  ;xoa thanh ghi dx ve 0
    div bx   ;ax = ax / bx, phan nguyen luu trong ax, phan du luu trong dx 
    inc cx   ;tang bien dem so lan chia len 1
    push dx   ;day phan du vao stack
    cmp al,0  ;so sanh xem phan nguyen = 0 hay khong, ax = 0 thi al = 0
    je display  ;neu phan nguyen = 0 tuc la da push het cac chu so vao stack thi thuc hien ham display
    jmp chia  ;neu khong thi thuc hien lai ham chia cho den khi phan nguyen = 0
display:
    pop dx  ;lay gia tri tren dinh stack luu vao dx
    add dl,30h  ;so nguyen + 30h de chuyen sang ma ASCII cua so nguyen do
    mov ah,2  ;hien thi gia tri cua ma ASCII
    int 21h
    dec cx  ;giam bien dem cx di 1
    cmp cx,0  ;so sanh bien dem cx voi 0
    jne display  ;neu cx # 0 thi thuc hien pop tiep stack cho den khi cx = 0
    jmp exit  ;khi bien dem cx = 0 thi return ve main
hienthi endp

end main

