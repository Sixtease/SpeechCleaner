#!/bin/bash

oklist="$1"
srcdir="$2"
destdir="$3"

usage() {
    echo "usage: $0 OKlist SrcDir DestDir"
    exit 1
}

if [ -z "$oklist" ]; then usage; fi;
if [ -z "$srcdir" ]; then usage; fi;
if [ -z "$destdir" ]; then usage; fi;

while read line; do
    if echo "$line" | grep -iq '# *test'; then continue; fi
    item=`echo "$line" | sed 's/ *#.*//'`
    if echo "$item" | grep -vq '.'; then continue; fi
    file=`ls "$srcdir/$item"*`
    if [ -z "$file" ]; then continue; fi
    echo $file
    ln -s "$file"* "$destdir";
done < "$oklist"
