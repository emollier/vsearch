#!/bin/sh

P=$1

#Q=../data/Rfam_9_1.fasta
#DB=../data/Rfam_9_1.fasta
Q=../data/BioMarKs50k.fsa
DB=../data/BioMarKs50k.fsa
T=0
ID=0.5
MR=32

USEARCH=$(which usearch)
VSEARCH=../src/vsearch

if [ "$P" == "u" ]; then
    PROG=$USEARCH
else
    if [ "$P" == "v" ]; then
        PROG=$VSEARCH
    else
        echo You must specify u or v as first argument
        exit
    fi
fi

/usr/bin/time $PROG \
    --usearch_global $Q \
    --db $DB \
    --threads $T \
    --strand plus \
    --id $ID \
    --match 2 \
    --mismatch -4 \
    --gapopen 20I/2E \
    --gapext 2I/1E \
    --maxaccepts 1 \
    --maxrejects $MR \
    --alnout alnout.$P.txt \
    --fastapairs fastapairs.$P.fsa \
    --dbmatched dbmatched.$P.fsa \
    --dbnotmatched dbnotmatched.$P.fsa
