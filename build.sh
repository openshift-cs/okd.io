#!/usr/bin/env sh

./node_modules/cspell/bin.js "docs/**/*.md"
mkdocs build
linkchecker -f linkcheckerrc public
