# MJM
Michael Jackson's Moonwalker Disassembly

## Motive:

The motive behind this repository is to provide the world's first diassembly of Micheal Jackson's Moonwalker (MD/Gen)

This project encompasses both REV00 and REV01, (Domestic and International) versions of the ROMS, which provide subtle differences in Z80 and VDP DMA

## Building:

```
git clone 

make clean

make
```

the output should be a file called ``MJM_R00.bin`` or ``MJM_R01`` depending on which compiler flag you choice to use

#### For REV00:

``make CLFAGS="-REV00"``

#### For REV01:

``make CLFAGS="-REV01"``
