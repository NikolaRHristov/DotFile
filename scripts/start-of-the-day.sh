#!/bin/bash

cd /d/Developer || exit

find -iname .git -execdir git add . \;
find -iname .git -execdir git commit --no-edit \;
