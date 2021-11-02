#!/usr/bin/env sh

set -e

./node_modules/cspell/bin.js "docs/**/*.md"
mkdocs build
linkchecker -f linkcheckerrc public
