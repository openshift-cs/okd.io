#!/usr/bin/env sh


PORT=${1:-8000}

mkdocs serve --dirtyreload -a "0.0.0.0:${PORT}"
