#!/bin/sh
# requirements: fzf, coreutils (or toybox, busybox etc.)

cat > file.rozkaz << EOF
.DRUŻYNA 19 Poznańska Drużyna Harcerzy “Puszcza”
.sp 1
.DATA Data: \l'1i'
.sp 1
.ad c
.ps +4
Wypożyczenie sprzętu
.ps
.br
.ad b
.sp 1
.TS
tab(,) allbox center;
c l lw25 cw15 .
L.p.,Zastęp,Sprzęt,Stan
EOF
for f in zastępy/*; do cat $f | xargs -I {} echo $(basename $f .csv),{}; done | fzf -m --bind ctrl-a:select-all,ctrl-d:deselect-all | cut -d, -f1-4 | nl -w1 -s, >> file.rozkaz
cat >> file.rozkaz << EOF
.TE

Numer telefonu: \l'2i'

Planowany termin zwrotu: \l'2i'


\l'2i'

Podpis wypożyczającego
.br
.ad r
.sp -4

\l'2i'

Podpis wydającego sprzęt
.br
EOF
compiler file.rozkaz
