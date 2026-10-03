YASM      := yasm
YASMFLAGS := -f elf64 -g dwarf2

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
	$(YASM) $(YASMFLAGS) $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f *.o $(TARGET)