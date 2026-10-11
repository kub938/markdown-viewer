#!/bin/zsh
set -euo pipefail
cd "${0:A:h}"
if [[ ! -d "Simple Markdown.app" ]]; then
    ./Build.command
fi
open "Simple Markdown.app"
