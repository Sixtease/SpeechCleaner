#!/bin/bash

infile="$1"; shift
outfile="$1"; shift
gain="$1"; shift

sox "$infile" "$outfile" vol "$gain"
