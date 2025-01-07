#!/bin/sh

files=$( ls met* )

for ff in $files
do 
    
    new=$( echo $ff | sed "s/d02/d01/g")

    mv $ff $new

done
