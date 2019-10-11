#!/bin/bash

d=${KMAC_DIR:-"."}

method=mandelellis
if [[ "$1" = '-n' ]]; then
    shift
    method="$1"
    shift
fi

f1="$1"
f2="$2"
fid1=`basename "$f1" | sed 's/\.[a-zA-Z0-9]\+//'`
fid2=`basename "$f2" | sed 's/\.[a-zA-Z0-9]\+//'`
colfn="$d/temp/$fid1.$fid2.musly"
simfn="$d/temp/$fid1.$fid2.mirex"

musly -c "$colfn" -n "$method" > /dev/null
musly -c "$colfn" -a "$f1" > /dev/null
musly -c "$colfn" -a "$f2" > /dev/null
musly -c "$colfn" -m "$simfn" > /dev/null

tail -n 1 "$simfn" | cut -f 2

rm "$colfn" "$simfn"
