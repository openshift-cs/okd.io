#!/usr/bin/env sh

npm ci
./node_modules/cspell/bin.js "docs/**/*.md"
mkdocs build
linkchecker -f linkcheckerrc public
