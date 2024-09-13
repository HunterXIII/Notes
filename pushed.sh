#!/bin/bash

git add .
git restore --staged .obsidian/workspace.json
git commit -m "Сохранение_$(date +%d_%m_%Y_%H%M%S)"

ping -c 1 8.8.8.8 > /dev/null
if [[ $? -eq 0 ]]
then
    git push git@github.com:HunterXIII/Notes.git
fi
