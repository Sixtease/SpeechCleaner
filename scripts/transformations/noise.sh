#!/bin/bash

infile="$1"; shift
outfile="$1"; shift
level="$1"; shift

sox "$infile" -p synth whitenoise vol "$level" | sox -m "$infile" - "$outfile"
