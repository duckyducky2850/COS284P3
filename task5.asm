; Task 5: double weighted_rating(Book* books, long n){
;   double num = 0.0, den = 0.0;
;   for (long i = 0; i < n; ++i) {
;       num += books[i].rating * books[i].pages;   // int promoted to double
;       den += books[i].pages;
;   }
;   return num / den;
;}
; rdi = books,  rsi = n
; Return xmm0 (double)

;;Registers:
;   xmm0 = numerator accumulator   (must end as the final result)
;   xmm1 = denominator accumulator
;   xmm2 = scratch: (double)pages
;   xmm3 = scratch: rating

global weighted_rating
section .text
weighted_rating:
    pxor xmm0, xmm0  ; numerator = 0.0
    pxor xmm1, xmm1 ; denominator = 0.0
.loop:
    cvtsi2sd xmm2, dword [rdi + 16] ; (double)pages
    addsd xmm1, xmm2  ; den += pages
    movsd xmm3, [rdi + 8] ; rating
    mulsd xmm3, xmm2 ; rating * pages
    addsd xmm0, xmm3 ; num += rating * pages
    add rdi, 24
    dec rsi
    jnz .loop
    divsd xmm0, xmm1
    ret
