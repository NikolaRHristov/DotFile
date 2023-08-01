#!/bin/bash

cd /d/Developer || exit

inn -p -f .git git add .
inn -p -f .git git commit -m squash!
inn -p -f .git git sync
inn -p -f .git git fetch upstream
inn -p -f .git git merge upstream/main
inn -p -f .git git sync

inn -p .git git add .
inn -p .git git commit -m squash!
inn -p .git git sync
inn -p .git git fetch upstream
inn -p .git git merge upstream/main
inn -p .git git sync
