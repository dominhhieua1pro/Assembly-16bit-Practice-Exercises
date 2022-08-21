.model small
.stack 100
.data
str db 13,10,"Hello World!$" 
str2 db 50,0,50 dup('$')   ;byte dau la kich thuoc buffer, byte thu 2 la so ky tu thuc su duoc doc
; 13 la ky tu enter
; 10 la ky tu newline (\n)
mang db 1,3,7,9,0,14,21,23,45,35,40 

.code
main proc
    mov AX, @data
    mov DS, AX
    
    ;interrupt number 1 : nhap 1 ky tu va luu dang hexa vào thanh ghi AL
    mov AH,1
    int 21h  
        
    ;interrupt number 2 : hien thi 1 ky tu
    mov AH,2   
    mov DL,45h
    int 21h  ; console: E
    
    ;interrupt number 9 : hien thi xau chuoi co ket thuc la '$' va co dia chi lech la gia tri cua DX    
    mov AH,9
    lea DX, str  ; or mov DX, OFFSET str - gan dia chi lech cua str vào DX
    int 21h  ; console: Hello World!
    
    ;interrupt number 4CH : dung va ket thuc chuong trinh
    mov AH,4Ch  ; <=> mov AH,76
    int 21h                          
    
    ;interrupt number 10 (0A) : nhap 1 chuoi ky tu tu ban phim va luu chuoi tu index 2 cua mang
    lea dx,str2
    mov ah,0Ah  ; nhap chuoi
    int 21h        
    
    lea dx,str2 + 2
    mov ah,9    ; in ra chuoi vua nhap
    int 21h                                         
    
    mov cl,str2 + 1  ; lay ra so luong ky tu duoc nhap vao
                    
    ;add
    mov AL,4
    mov BL,5
    add AL,BL  ; AL = 09
    
    ;sub    
    mov AL,8
    mov BL,5
    sub AL,BL  ; AL = 03
    
    ;mul 
    mov AL,200  ; AL = 0C8h
    mov BL,4
    mul BL  ; AL = AL * BL (thanh ghi 8bit)
 	    ;; neu ket qua vuot qua 8bit thi luu vào AX (thanh ghi 16bit) => AX = 0320h
    
    ;div kieu byte (thanh ghi 8bit - byte)
    mov AX,20  ; AX = 14h duoc chuyen thanh decimal roi thuc hien phep chia
    mov BX,6
    div BL  ; AL = AX / BX, phan nguyen luu trong AL => AL = 03, phan du luu trong AH => AH = 02
    
    ;div kieu word (thanh ghi 16bit - word)
    mov AX,20
    mov BX,6
    div BX  ; AX = (DX AX) / BX, phan nguyen luu trong AX => AX = 0003h, phan du luu trong DX => DX = 0002h

    ;loop
    lea DX, str
    mov CX,5  ; 5 là so lan lap, qua moi vong lap thi CX giam di 1, khi CX = 0 thi dung vong loop
    mov AH,9
loopName:   
    int 21h 
    loop loopName  ; console: Hello World!Hello World!Hello World!Hello World!Hello World!
    
    ;push
    mov DL,35h  
    push DX  ; day so nguyen 5 vao stack
    
    ;pop
    pop DX  ; push DX thi pop DX
    mov AH,2
    int 21h
    ;; push va pop thuong di cung voi vong loop, qua moi luot loop thi CX (or CL 8bit) giam di 1
    
    ;adc
    adc dl,0  ; tuong tu add nhung cong them voi flag CF
    
    ;shl
    mov dl,30h  ; de dl + 1 thanh so nguyen 1 trong he thap phan ma ASCII
    shl bx,1  ; dich trai 1 bit, bit bi dich (ben trai cung) duoc luu vao flag CF
    adc dl,0  ; lay dl add 0 va add flag CF
    mov ah,2  ; hien thi ket qua dl
    int 21h
    
    ;thanh ghi si
    lea si,mang  ; gan dia chi cua mang cho si (la dia chi cua phan tu dau tien cua mang)
    mov ax,[si]  ; gan gia tri cua phan tu dau tien cua mang vao thanh ghi ax thi phan tu hien tai luu vao al, phan tu ke tiep luu vao ah
                 ; tuong tu cac phan tu tiep theo
    inc si  ; tang dia chi len 1 byte de chuyen sang phan tu tiep theo
    ;; thanh ghi dx(dl) cung co the duoc thay the cho thanh ghi ax
    mov dl,[si]  ; gan gia tri cua phan tu co dia chi si vao thanh ghi dl
    
        
main endp
;cac chuong trinh con neu co
end main