;double average_rating(Book* books, long n){
;   double sum = 0.0;
;   for (long i = 0; i < n; ++i) sum += books[i].rating;
;   return sum / n; //n converted to double
; }

;;arguments: rdi books, rsi n
;;retuen xmm0 (its a double)
global average_rating
section .text
average_rating:
    pxor xmm0, xmm0 ; sum = 0.0
    cvtsi2sd xmm1, rsi ; (double)n, converted before loop uses rsi as a counter
    ; needs n to be double to get sum / n, save copy in xmm1
.loop:
    addsd xmm0, [rdi + 8] ; sum += books[i].rating
    add rdi, 24
    dec rsi
    jnz .loop
    divsd xmm0, xmm1 ; sum / n  (result stays in xmm0)
    ret