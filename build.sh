#!/bin/bash
rm -rf target/
mkdir target

cd src

cl65 -O -t c64 ultimate_ii.c u-sample.c -o ../target/u-sample.prg
cl65 -O -t c64 ultimate_ii.c u-shell.c -o ../target/u-shell.prg
cl65 -O -t c64 ultimate_ii.c ultimateterm.c -o ../target/u-term64.prg
cl65 -O -t c64 ultimate_ii.c u-chat.c -o ../target/u-chat64.prg
cl65 -O -t c128 ultimate_ii.c ultimateterm.c -o ../target/u-term128.prg
cl65 -O -t c128 ultimate_ii.c u-chat.c -o ../target/u-chat128.prg
cl65 -t geos-cbm -O -o ../target/geouterm.cvt geouterm-res.grc ultimate_ii.c geouterm.c

cat u-term.seq | tr "\n" "\r" >../target/u-term.seq

rm -f *.o
rm -f *.inf

cd ../target

c1541 -format "ultimatedemos,sh" d64 ultimatedemos.d64
c1541 -format "ultimate-term,sh" d64 ultimate-term.d64

c1541 -attach ultimatedemos.d64 -write u-term64.prg u-term64
c1541 -attach ultimatedemos.d64 -write u-term128.prg u-term128
c1541 -attach ultimatedemos.d64 -write u-term.seq u-term,s
c1541 -attach ultimatedemos.d64 -write u-shell.prg u-shell
c1541 -attach ultimatedemos.d64 -write u-chat64.prg u-chat64
c1541 -attach ultimatedemos.d64 -write u-chat128.prg u-chat128
c1541 -attach ultimatedemos.d64 -geoswrite ../src/cbm40.cvt
c1541 -attach ultimatedemos.d64 -geoswrite ../src/cbm80.cvt
c1541 -attach ultimatedemos.d64 -geoswrite geouterm.cvt

c1541 -attach ultimate-term.d64 -write u-term64.prg u-term64
c1541 -attach ultimate-term.d64 -write u-term128.prg u-term128
c1541 -attach ultimate-term.d64 -write u-term.seq u-term,s

rm -f u-term.seq

cd ..