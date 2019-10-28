#!/bin/bash

# Toto by mělo vytvořit soubor, ve kterém bude další úsek z trénovací množiny.
# Prvních 10 sekund se zahodí a pak se generujou kousky o délce $len samplů.
# Nedomrlky z konce souboru se zahodí.
# Ještě jsem nepochopil, jak se řeší vyčerpání dat.

outfile="$1"; shift
datadir="data/train"
statefile='temp/__aac1_traingen_state'
starttrim=480000
len=5292000

lastfile=`grep file "$statefile" | cut -d : -f 2`
lastpos=`grep position "$statefile" | cut -d : -f 2`

savepos() {
    echo -e "file:$1\nposition:$2" > "$statefile"
}

if [ -z "$lastfile" ]; then
    file=`ls "$datadir" | head -n 1`;
    pos="$starttrim"
else
    file="$lastfile"
    pos="$lastpos"
fi

endpos="$(( $pos + $len ))"
echo -n "$file $pos .. $endpos ... "
sox "$datadir/$file" "$outfile" trim "$pos"s "$len"s > /dev/null
reallen=`soxi "$outfile" | grep -o '[0-9]\+ samples' | cut -d ' ' -f 1`

if [ "$reallen" -eq "$len" ]; then
    echo OK
    savepos "$file" "$endpos"
elif [ -z "$reallen" ]; then
    echo failed
    savepos "$file" "$endpos"
    exit 2
elif [ "$reallen" -lt "$len" ]; then
    echo too short
    rm "$outfile"
    newfile=`ls "$datadir" | grep -A 1 "$lastfile" | tail -n +2`
    if [ -z "$newfile" ]; then
        echo no more files
        exit 1
    fi
    savepos "$newfile" "$starttrim"
    exec "$0" "$outfile"
fi
