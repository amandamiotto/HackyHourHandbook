#!/bin/bash

for i in `seq 1 5`;
do
    qsub -v INPUT=$i test.pbs
done
