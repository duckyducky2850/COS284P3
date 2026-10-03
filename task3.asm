; Task 3: long count_above(Book* books, long n, double threshold);
;
; Arguments:  rdi = books,  rsi = n,  xmm0 = threshold
;             (integer/pointer args and floating args are numbered
;              separately: the double is the FIRST floating arg, so xmm0)
; Return:     rax (a long)
;
; C++ equivalent:
;   long count = 0;
;   for (long i = 0; i < n; ++i)
;       if (books[i].rating > threshold) ++count;
;   return count;
;
; New ideas:
;   - Comparing doubles: comisd xmm_a, xmm_b (or ucomisd). It sets CPU
;     flags like an integer cmp, but the flags it sets behave like an
;     UNSIGNED comparison. So use the "above/below" jumps, not the
;     "greater/less" ones:
;         ja  = jump if a >  b
;         jae = jump if a >= b
;         jb  = jump if a <  b
;     Think of it as: floats borrow the unsigned jump family.
;   - Strictly greater than means the book's rating must be the FIRST
;     operand and threshold the second, then use ja (not jae).
;   - Careful: comisd needs a register as its first operand, so load the
;     rating into a spare xmm register first (movsd xmm1, [rdi + 8]).
;
; Plan:
;   1. count (rax) = 0
;   2. loop:
;        - load rating into xmm1
;        - comisd xmm1, xmm0
;        - if not above, skip the increment   (jbe .skip)
;        - inc rax
;      .skip:
;        - advance rdi by 24, count down, jnz .loop
;   3. ret

global count_above

section .text
count_above:
    ; TODO: zero rax

.loop:
    ; TODO: movsd xmm1, [rdi + 8]
    ; TODO: comisd xmm1, xmm0
    ; TODO: jbe .skip           (skip when NOT strictly greater)
    ; TODO: inc rax
.skip:
    ; TODO: advance rdi by 24
    ; TODO: dec rsi / jnz .loop

    ret

section .note.GNU-stack noalloc noexec nowrite progbits
