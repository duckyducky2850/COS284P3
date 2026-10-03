; Task 1: long total_pages(Book* books, long n);
;
; struct Book layout (what C does, what you must replicate by hand):
;   offset  0 : int    id       (4 bytes)
;   offset  4 : -- 4 bytes padding so the double is 8-byte aligned --
;   offset  8 : double rating   (8 bytes)
;   offset 16 : int    pages    (4 bytes)
;   offset 20 : -- 4 bytes tail padding so sizeof(Book) is a multiple of 8 --
;   sizeof(Book) == 24
; (In C++ you can verify with offsetof(Book, pages) and sizeof(Book).)
;
; Arguments (System V AMD64):  rdi = books,  rsi = n
; Return value:                rax
;
; C++ equivalent:
;   long total = 0;
;   for (long i = 0; i < n; ++i) total += books[i].pages;
;   return total;
;
; Plan:
;   1. total (rax) = 0
;   2. loop n times:
;        - read the 32-bit 'pages' at [rdi + 16]
;        - sign-extend it to 64 bits (movsxd) before adding, because
;          'pages' is an int but total is a long
;        - add it to rax
;        - move rdi on by sizeof(Book) = 24 bytes (like ++ptr in C++)
;        - decrement the counter, jump back while not zero
;   3. ret

global total_pages

section .text
total_pages:
    ; TODO: zero the accumulator

.loop:
    ; TODO: movsxd the pages field and add it to the accumulator
    ; TODO: advance rdi by 24
    ; TODO: dec rsi / jnz .loop

    ret

section .note.GNU-stack noalloc noexec nowrite progbits
