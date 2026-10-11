#!/bin/zsh
set -euo pipefail
cd "${0:A:h}"
mkdir -p .build/module-cache
xcrun swiftc -parse-as-library -module-cache-path "$PWD/.build/module-cache" \
    Sources/SimpleMarkdown/MarkdownDocument.swift \
    Sources/SimpleMarkdown/MarkdownBlocks.swift \
    Checks/Checks.swift -o .build/MarkdownChecks
.build/MarkdownChecks
