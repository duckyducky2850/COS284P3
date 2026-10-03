; Task 5: double weighted_rating(Book* books, long n);
;
; Arguments:  rdi = books,  rsi = n
; Return:     xmm0 (double)
;
;                 sum(rating_i * pages_i)
;   result  =  ---------------------------
;                    sum(pages_i)
;
; C++ equivalent:
;   double num = 0.0, den = 0.0;
;   for (long i = 0; i < n; ++i) {
;       num += books[i].rating * books[i].pages;   // int promoted to double
;       den += books[i].pages;
;   }
;   return num / den;
;
; This task combines everything from Tasks 1 and 2:
;   - 'rating * pages' in C++ silently promotes the int to double. In
;     assembly: load the int, then cvtsi2sd it into an xmm register, then
;     mulsd with the rating.
;   - cvtsi2sd takes a 32-bit or 64-bit integer operand. 'pages' is a
;     32-bit int at [rdi + 16], so a 32-bit load/convert is what you want
;     (cvtsi2sd xmm, dword [mem] is allowed in NASM).
;   - The denominator can be kept as a double too (simplest: reuse the
;     converted pages value and addsd it), or as an integer sum converted
;     once at the end. Either works, pick whichever you find easier to read.
;
; Registers (suggested):
;   xmm0 = numerator accumulator   (must end as the final result)
;   xmm1 = denominator accumulator
;   xmm2 = scratch: (double)pages
;   xmm3 = scratch: rating
;
; Plan:
;   1. zero xmm0 and xmm1 (pxor)
;   2. loop:
;        - cvtsi2sd xmm2, dword [rdi + 16]     (pages -> double)
;        - addsd xmm1, xmm2                    (den += pages)
;        - movsd xmm3, [rdi + 8]               (rating)
;        - mulsd xmm3, xmm2                    (rating * pages)
;        - addsd xmm0, xmm3                    (num += ...)
;        - advance rdi by 24, dec rsi, jnz .loop
;   3. divsd xmm0, xmm1
;   4. ret

global weighted_rating

section .text
weighted_rating:
    ; TODO: pxor xmm0, xmm0
    ; TODO: pxor xmm1, xmm1

.loop:
    ; TODO: cvtsi2sd xmm2, dword [rdi + 16]
    ; TODO: addsd xmm1, xmm2
    ; TODO: movsd xmm3, [rdi + 8]
    ; TODO: mulsd xmm3, xmm2
    ; TODO: addsd xmm0, xmm3
    ; TODO: add rdi, 24
    ; TODO: dec rsi / jnz .loop

    ; TODO: divsd xmm0, xmm1
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
