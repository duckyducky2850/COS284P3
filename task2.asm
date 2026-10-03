; Task 2: double average_rating(Book* books, long n);
;
; Arguments:  rdi = books,  rsi = n
; Return:     xmm0 (doubles are returned in xmm0, NOT rax)
;
; C++ equivalent:
;   double sum = 0.0;
;   for (long i = 0; i < n; ++i) sum += books[i].rating;
;   return sum / n;          // n is implicitly converted to double
;
; Things that are new compared to Task 1:
;   - Floating point lives in the xmm registers and uses its own
;     instructions: movsd (load/store a double), addsd, divsd.
;   - Zeroing a double accumulator: pxor xmm0, xmm0 (like double sum = 0.0).
;   - 'sum / n' in C++ silently converts n to double. In assembly you do
;     that yourself with cvtsi2sd (convert signed integer to scalar double).
;   - The rating field is at offset 8 within each 24-byte Book.
;
; Plan:
;   1. zero an xmm accumulator
;   2. save/convert n to double in another xmm register BEFORE the loop
;      (or after, but remember the loop is going to use rsi as the counter,
;      so convert first or keep a copy)
;   3. loop: addsd acc, [rdi + 8]; advance rdi by 24; count down
;   4. divsd acc, n_as_double
;   5. make sure the result ends up in xmm0, then ret

global average_rating

section .text
average_rating:
    ; TODO: pxor xmm0, xmm0             (sum = 0.0)
    ; TODO: cvtsi2sd xmm1, rsi          (xmm1 = (double)n)

.loop:
    ; TODO: addsd xmm0, [rdi + 8]
    ; TODO: advance rdi by 24
    ; TODO: dec rsi / jnz .loop

    ; TODO: divsd xmm0, xmm1
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
