#!/usr/bin/env sh

[ ! -d "node_modules" ] && npm ci

./node_modules/cspell/bin.js "docs/**/*.md"
mkdocs build
linkchecker -f linkcheckerrc public || true
