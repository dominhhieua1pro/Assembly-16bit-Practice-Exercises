.model small
.stack 100
.data
;khai bao bien va hang
    s db 13,10,"Good morning!$"
    t db 13,10,"Good afternoon!$"
    c db 13,10,"Good everning!$"
.code
main proc
;khoi tao DS
    mov ax, @data
    mov ds, ax
;code something
    mov ah,1
    int 21h
    mov ah,9
    cmp al,'S'
    je Morn
    cmp al,'s'
    je Morn
    cmp al,'T'
    je After
    cmp al,'t'
    je After
    cmp al,'C'
    je Even
    cmp al,'c'
    je Even
    jmp Exit
Morn:
    lea dx,s    
    int 21h
    jmp Exit
After:
    lea dx,t
    int 21h
    jmp Exit
Even:
    lea dx,c
    int 21h
    jmp Exit
Exit:
    mov ah, 4ch
    int 21h    

main endp
;cac chuong trinh con neu co
end main