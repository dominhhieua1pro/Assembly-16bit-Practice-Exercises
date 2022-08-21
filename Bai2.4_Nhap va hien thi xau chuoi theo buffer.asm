.model small
.stack 100
.data
;khai bao bien va hang
    str DB 10,13, 'Xin chao $'  
    mang DB 60, ?, 60 dup('$'), '$'  ;byte dau la kich thuoc buffer, byte thu 2 la so ky tu thuc su duoc doc
    ;de in mang thi gan dia chi cua phan tu co index 2 cho thanh ghi dx va int 21h voi mov ah,9
.code                          
main proc
    ;khoi tao DS
    mov ax, @data
    mov ds, ax
    ;code something  
    ;nhap chuoi ky tu
    mov ah,0Ah
    lea dx,mang
    int 21h         
    mov ah,9
    lea dx,str
    int 21h
    ;dua dx chi ve phan tu thu 2 cua mang la ky tu dau tien duoc nhap vao
    lea dx,mang+2  ;hoac mov dx, offset mang+2  ;(+2 byte)     
    int 21h
           
    ;ket thuc chuong trinh
    mov ah, 4ch
    int 21h
main endp
;cac chuong trinh con neu co
end main