.model small
.stack 100
.data
tb1 DB 'nhap xau A: $'
tb2 DB 13,10,'nhap xau B: $'
exist DB 13,10,'xau B co ton tai trong xau A$'
notExist DB 13,10,'xau B khong ton tai trong xau A$'
a DB 100 DUP(?)
b DB 100 DUP(?)

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ;nhap xau A
    lea dx, tb1
    mov ah, 9
    int 21h

    lea si, a
    call doc
    
    ;nhap xau B
    lea dx, tb2
    mov ah, 9
    int 21h
    
    lea si, b
    call doc
    
    ;check tung ky tu cua chuoi B voi ky tu chuoi A, neu same thi inc index de compare tiep
    lea si, a
chuathay:
    lea di, b
dathay:
    mov bl, [si]
    mov bh, [di]
    cmp bh, 24h
    je tontai
    cmp bl, 24h
    je khongtontai
    inc si
    cmp bl, bh
    jne chuathay
    inc di
    jmp dathay
khongtontai:
    lea dx, notExist
    mov ah, 9
    int 21h
    jmp ketthuc
tontai:
    lea dx, exist
    mov ah, 9
    int 21h
ketthuc:
    mov ah, 4ch
    int 21h
main endp

doc proc
    mov ah, 1
doctiep:
    int 21h
    cmp al, 13
    je docxong
    mov [si], al
    inc si
    jmp doctiep
docxong:
    mov [si], '$'
    ret
doc endp

end main