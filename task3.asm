; Task 3: long count_above(Book* books, long n, double threshold){
;   long count = 0;
;   for (long i = 0; i < n; ++i)
;       if (books[i].rating > threshold) ++count;
;   return count;
;   }

;rdi = books,  rsi = n,  xmm0 = threshold

global count_above
section .text
count_above:
    xor rax, rax ; count = 0   (threshold arrives in xmm0)
.loop:
    movsd xmm1, [rdi + 8] ; rating
    comisd xmm1, xmm0 ; compare rating with threshold
    jbe .skip ; not strictly greater -> skip increment
    inc rax
.skip:
    add rdi, 24
    dec rsi
    jnz .loop
    ret