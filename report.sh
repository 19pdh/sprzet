#!/bin/sh
## Usage: report.sh [NAZWA_ZASTĘPU]
## NAZWA_ZASTĘPU z folderu /zastępy bez rozszerzenia csv

(cat <<EOF
.so rozkaz.tmac
.DRUŻYNA 19 Poznańska Drużyna Harcerzy “Puszcza”
.DATA Poznań, $(LC_ALL="pl_PL" date "+%d %B %Y")
.ad c
.ps 16
.B "Spis sprzętu zastępu “$1”"
.ps 13
.sp 1
.br
.ad b

.TS
tab(,) allbox center;
c l l c .
L.p.,Sprzęt,Opis,Miejsce przechowania
EOF
nl -w1 -s, zastępy/$1.csv
echo .TE
) | tbl | roff -ms -meps | post -p 2970x2100 | ps2pdf - -
