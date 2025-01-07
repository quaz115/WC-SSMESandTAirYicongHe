#!/bin/csh

if ($1 == '-a') goto main

./run.sh -a

exit 0

main:

echo 'HERE'

exit 0
