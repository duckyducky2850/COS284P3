;long total_pages(Book* books, long n){
;   long total = 0;
;   for (long i = 0; i < n; ++i) total += books[i].pages;
;   return total;
;   }

; note:
;books in rdi (1st arg)
;n in rsi
;;return val in rax aka where total should be

global total_pages
section .text
total_pages:
;for the books[i]:
    ; offset:
    ;0  id
    ;4  padding
    ;8  rating
    ;12 rating
    ;16 pages

;loop n times
; for (i = 0; i < n; i++)      n in rsi
    xor rax, rax ;total = 0
    xor rcx, rcx ;i=0
.for:
    cmp rcx, rsi
    jge .endfor
        ; body
        movsxd rdx, dword [rdi + 16] ;get pages, convert int to long
        add rax, rdx ;total += pages
        add rdi, 24 ;each book is 24 bits apart, so "go to next book"
    inc rcx ;i++
    jmp .for
.endfor:
    ret

