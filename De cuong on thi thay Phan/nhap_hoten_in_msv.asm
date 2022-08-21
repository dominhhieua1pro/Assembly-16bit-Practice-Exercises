;nhap ho ten in msv
.model small
.stack 100h
.data  
  tb1 db 10,13,'nhap vao ho ten cua ban : $'
  hoten db 'DINH THI THU',13,'$'
  tb2 db 10,13,'ban nhap sai ten,hay nhap lai  $'  
  tb3 db 10,13,'MSV cua ban la : AT160350 $'
  chuoi db  100,0,100 dup('$')
    

.code
 main proc  
    mov ax,@data
    mov ds,ax
   nhap:
    mov ah,9
    lea dx,tb1
    int 21h
    
    mov ah,10
    lea dx,chuoi
    int 21h
    
    lea si,chuoi+2
    xor cx,cx
    mov cl,[chuoi+1]
    
    chuyen:
      cmp [si],'a'
      jl next
      cmp [si],'z'
      jg next
      sub [si],20h
      
    next:
      inc si
      loop chuyen  
      
    lea si,chuoi+2
    xor cx,cx
    mov cl,[chuoi+1]  
    lea di,hoten
    
    lap:
     mov ax,0
     mov al,[si]
     cmp al,[di]
     jne notsame
     inc si
     inc di
     loop lap
     
     mov ah,9
     lea dx,tb3
     int 21h 
     jmp exit
     
     notsame:
      mov ah,9
      lea dx,tb2
      int 21h
      jmp nhap
     
    exit:
     mov ah,4ch
     int 21h
     
      
      
      
 main endp