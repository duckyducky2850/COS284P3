;Book* best_book(Book* books, long n){
;   Book* best = &books[0];
;   for (long i = 1; i < n; ++i)
;       if (books[i].rating > best->rating)   // strictly greater!!
;           best = &books[i];
;   return best;
;}
;rdi = books,  rsi = n
;Return rax = ptr to the best book
;

global best_book
section .text
best_book:
    mov rax, rdi ; best = &books[0]
    movsd xmm0, [rdi + 8]  ; bestRating = books[0].rating
    add rdi, 24
    dec rsi
    jz .done; n == 1: nothing left to check
.loop:
    movsd xmm1, [rdi + 8]
    comisd xmm1, xmm0
    jbe .skip ; keep old best unless strictly greater
    mov rax, rdi ; best = &books[i]
    movsd xmm0, xmm1
.skip:
    add rdi, 24
    dec rsi
    jnz .loop
.done:
    ret
