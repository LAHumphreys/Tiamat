#!/bin/bash

sheet=$1
toolDir=$(dirname $BASH_SOURCE)

input=""
roll=""
while [[ $input != "q" ]]; do
    echo "$input " | awk -f $toolDir/dice.awk
    echo -n ">> "
    read input
    if [[ $input =~ [a-zA-Z][a-zA-Z] ]]; then
        roll=$($toolDir/rollFinder.sh $sheet $input)
    else
        roll=""
    fi
    if [[ $roll != "" ]]; then
        echo $roll
        input=$(echo $roll | awk 'BEGIN {FS=":"} {print $2}')
    fi
done
