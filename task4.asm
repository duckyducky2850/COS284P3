;Book* best_book(Book* books, long n){
;   Book* best = &books[0];
;   for (long i = 1; i < n; ++i)
;       if (books[i].rating > best->rating)   // strictly greater!
;           best = &books[i];
;   return best;
;}
;rdi = books,  rsi = n
;Return rax = ptr to the best book
;

global count_above
section .text
count_above:
    xor rax, rax ; count = 0   (threshold arrives in xmm0)
.loop:
    movsd xmm1, [rdi + 8] ; rating
    comisd xmm1, xmm0 ; compare rating with threshold
    jbe .skip ; not strictly greater -> skip
    inc rax
.skip:
    add rdi, 24
    dec rsi
    jnz .loop
    ret
