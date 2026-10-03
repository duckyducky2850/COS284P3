# COS284 Practical 3 - Functions and Structs
#
# C++ analogy: this is the usual compile -> link pipeline.
#   nasm  = the "compile" step, each .asm becomes a .o (like g++ -c)
#   gcc   = the "link" step, glues main.o + task*.o into ./library
# The pattern rules below are the same idea as writing one rule per
# translation unit, just generalised with % (a wildcard).

NASM      := nasm
NASMFLAGS := -f elf64 -g -F dwarf

CC        := gcc
CFLAGS    := -Wall -Wextra -g -no-pie

ASM_SRCS  := task1.asm task2.asm task3.asm task4.asm task5.asm
ASM_OBJS  := $(ASM_SRCS:.asm=.o)

TARGET    := library

.PHONY: all clean run

all: $(TARGET)

# link step
$(TARGET): main.o $(ASM_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# "compile" step for C
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# "compile" step for assembly
%.o: %.asm
	$(NASM) $(NASMFLAGS) $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f *.o $(TARGET)
