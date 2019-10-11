#!/bin/bash

infile="$1"; shift
outfile="$1"; shift
factor="$1"; shift

sox "$infile" "$outfile" speed "$factor"
