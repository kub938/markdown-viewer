#!/bin/zsh
set -euo pipefail
cd "${0:A:h}"
if ! xcrun --find swift >/dev/null 2>&1; then
    echo "Apple 개발 도구가 필요합니다. 터미널에서 xcode-select --install 실행 후 다시 시도하세요."
    read -r "?Enter를 누르면 닫힙니다. "
    exit 1
fi
mkdir -p .build/module-cache
swift build -c release --scratch-path .build -Xswiftc -module-cache-path -Xswiftc "$PWD/.build/module-cache"
BIN_DIR=$(swift build -c release --scratch-path .build --show-bin-path)
APP="$PWD/Simple Markdown.app"
mkdir -p "$APP/Contents/MacOS"
cp "$BIN_DIR/SimpleMarkdown" "$APP/Contents/MacOS/SimpleMarkdown"
cp Resources/Info.plist "$APP/Contents/Info.plist"
codesign --force --sign - "$APP"
echo "완료: $APP"
