#!/bin/bash

cd /f/Developer || exit

find -iname .git -execdir git add . \;
find -iname .git -execdir git commit --no-edit \;
