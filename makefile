## COPYRIGHT (C) HARRY CLARK 2024
## MICHAEL JACKSON'S MOONWALER DISASSEMBLY

AS = m68k-elf-gcc
LD = m68k-elf-ld

ASFLAGS = -m68000 -x assembler-with-cpp
LDFLAGS = -Ttext=0x0 --oformat=binary

MAIN = moonwalker.asm
OUTPUT_REV00 = MJM_R00.bin
OUTPUT_REV01 = MJM_R01.bin

CLFLAGS ?= -DGAME_REV=0

all: $(OUTPUT_REV00) $(OUTPUT_REV01)

# REV00
$(OUTPUT_REV00): $(MAIN) header.asm macros.asm
	$(AS) $(ASFLAGS) $(CLFLAGS) -DGAME_REV=0 -c $(MAIN) -o moonwalker_rev00.o
	$(LD) $(LDFLAGS) moonwalker_rev00.o -o $@

# REV01
$(OUTPUT_REV01): $(MAIN) header.asm macros.asm
	$(AS) $(ASFLAGS) $(CLFLAGS) -DGAME_REV=1 -c $(MAIN) -o moonwalker_rev01.o
	$(LD) $(LDFLAGS) moonwalker_rev01.o -o $@

clean:
	rm -f *.o $(OUTPUT_REV00) $(OUTPUT_REV01)
