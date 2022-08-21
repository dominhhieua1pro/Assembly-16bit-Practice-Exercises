.model small
.stack 100
.data
str1 db "Hay go 1 phim: $"
str2 db 0Dh,0Ah,"Ky tu ke truoc: $"
str3 db 0Dh,0Ah,"Ky tu ke sau: $"
tmp db ?
;crlf equ 13, 10, "$"
.code
main proc
    ;nhap ky tu hexa 
    mov AX,@data
    mov DS, AX
    mov AH,9
    lea DX,str1  ;or mov DX, OFFSET str1
    int 21h
    mov AH,1
    int 21h  ;gia tri hexa cua ky tu vua nhap duoc luu vao thanh ghi AL
    mov tmp,AL   ;luu gia tri AL vao 1 bien tam thoi (temporary)
    ;hien thi ky tu ke truoc
    mov AH,9
    lea DX,str2
    int 21h
    mov AH,2
    mov DL,tmp
    dec DL    
    int 21h
    ;hien thi ky sau ke sau
    mov AH,9
    lea DX,str3
    int 21h
    mov AH,2
    mov DL,tmp
    inc DL
    int 21h
    ;ket thuc chuong trinh
    mov AH,4Ch 
    int 21h            
main endp
end main