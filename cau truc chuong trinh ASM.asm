.model small
.stack 100
.data
;khai bao bien va hang
.code
main proc
;khoi tao DS
mov ax, @data
mov ds, ax
;code something
;ket thuc chuong trinh
mov ah, 4ch
int 21h
main endp
;cac chuong trinh con neu co
end main