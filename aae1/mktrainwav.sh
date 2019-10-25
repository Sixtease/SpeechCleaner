#!/bin/bash

# Toto by mělo vytvořit soubor, ve kterém bude další úsek z trénovací množiny.
# Prvních 10 sekund se zahodí a pak se generujou kousky o délce $len.
# Nedomrlky z konce souboru se zahodí (sox vypíše něco o not reached).
# Ještě jsem nepochopil, jak se řeší vyčerpání dat.

outfile="$1"; shift
statefile='temp/__aac1_traingen_state'
starttrim=10
len=5292000s

lastfile=`grep file "$statefile" | cut -d : -f 2`
lastpos=`grep position "$statefile" | cut -d : -f 2`

if [ -z "$lastfile" ]; then
    file=`ls data/train/ | head -n 1`;
    pos="$starttrim"
fi


