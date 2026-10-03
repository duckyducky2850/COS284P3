; Task 4: Book* best_book(Book* books, long n);
;
; Arguments:  rdi = books,  rsi = n
; Return:     rax = POINTER to the best book (an address, not a rating)
;
; C++ equivalent:
;   Book* best = &books[0];
;   for (long i = 1; i < n; ++i)
;       if (books[i].rating > best->rating)   // strictly greater!
;           best = &books[i];
;   return best;
;
; Why strictly greater matters: on a tie we must keep the FIRST book,
; so we only replace 'best' when we see something strictly bigger.
; (>= would return the last tied book and fail the marker's data.)
;
; Registers (suggested):
;   rax  = best pointer (also the return value, so no final mov needed)
;   xmm0 = best rating so far (cache it so you do not reload each time)
;   rdi  = current pointer, walking forward
;   rsi  = remaining count
;
; Plan:
;   1. rax = rdi; xmm0 = [rdi + 8]       (best starts as books[0])
;   2. n is at least 1, so books[0] is already handled: advance rdi by 24
;      and decrement rsi. If rsi hits zero, you are done (watch this
;      edge case, n == 1 must not loop around 2^64 times!)
;   3. loop:
;        - movsd xmm1, [rdi + 8]
;        - comisd xmm1, xmm0
;        - jbe .skip                (not strictly greater, keep old best)
;        - rax = rdi, xmm0 = xmm1   (new best; movsd xmm0, xmm1)
;      .skip:
;        - advance rdi by 24, dec rsi, jnz .loop
;   4. ret

global best_book

section .text
best_book:
    ; TODO: mov rax, rdi
    ; TODO: movsd xmm0, [rdi + 8]
    ; TODO: add rdi, 24 ; dec rsi ; jz .done   (handles n == 1)

.loop:
    ; TODO: movsd xmm1, [rdi + 8]
    ; TODO: comisd xmm1, xmm0
    ; TODO: jbe .skip
    ; TODO: mov rax, rdi
    ; TODO: movsd xmm0, xmm1
.skip:
    ; TODO: add rdi, 24
    ; TODO: dec rsi / jnz .loop

.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
