#!/bin/bash

toolDir=$(dirname $BASH_SOURCE)
sheet=$1
shift


cat $sheet | awk -f $toolDir/getStats.awk | grep "$*" | head -n 1
