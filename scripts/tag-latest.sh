#!/bin/bash

DEVDIR="/d/Developer/app"

mkdir -p $DEVDIR/"$USER"
cd $DEVDIR/"$USER" || exit

find -iname .git -execdir bash -c "${DEVDIR}"/NikolaRHristov/dot/lib/scripts/count.sh \;
