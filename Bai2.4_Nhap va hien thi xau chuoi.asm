.model small
.stack 100
.data
str1 db "Xin chao $"
CRLF DB 13, 10, '$'
str2 DB ?

.code
main proc
    mov ax, @data
    mov ds, ax    
    lea si, str2  ; thanh ghi si luu dia chi cua bien str2 la dia chi cua ky tu dau tien cua chuoi str2 (str2[0])
    mov ah, 1
readPerChar:
    int 21h
    cmp al, 13
    je display
    mov [si], al  ; [si] la lay ra gia tri du lieu cua o nho ma co dia chi la si (1byte = 1 ky tu)
    inc si  ; si++ se tro thanh dia chi o nho tiep theo de chua ky tu (hay la phan tu thu 2 cua mang)
    jmp readPerChar
display:
    mov [si], '$'
    mov ah, 9
    lea dx, CRLF
    int 21h
    lea dx, str1
    int 21h
    lea dx, str2
    int 21h
    mov ah, 4ch
    int 21h
main endp

end main