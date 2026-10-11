# Markdown Viewer

**열고, 쓰고, 저장하는 데 집중한 macOS Markdown 편집기.**

SwiftUI로 만든 작은 네이티브 앱입니다. 왼쪽에서 Markdown을 편집하고 오른쪽에서 결과를 바로 확인하세요. 계정, 별도 패키지, 복잡한 설정이 필요하지 않습니다.

![macOS 13+](https://img.shields.io/badge/macOS-13%2B-333333?logo=apple)
![Swift 5.9+](https://img.shields.io/badge/Swift-5.9%2B-F05138?logo=swift&logoColor=white)
![MIT License](https://img.shields.io/badge/License-MIT-blue)

## 다운로드하고 실행하기

1. [최신 릴리스](https://github.com/kub938/markdown-viewer/releases/latest)에서 **MarkdownViewer-macOS-arm64.zip**을 받습니다.
2. 압축을 풀고 **Simple Markdown.app**을 실행합니다. 원하는 경우 응용 프로그램 폴더로 옮겨도 됩니다.
3. 파일 선택 창에서 `.md` 파일을 열거나 **New Document**를 눌러 새 문서를 만듭니다.

> 제공 앱은 **Apple Silicon(M1 이상)**용입니다. 최소 지원 버전은 **macOS 13**입니다. Intel Mac은 아래 방법으로 직접 빌드하세요. 배포 앱은 로컬 ad-hoc 서명으로 제작했으며 Apple Developer ID 서명과 공증은 되어 있지 않습니다. macOS에서 실행을 차단하면 소스에서 직접 빌드할 수 있습니다.

## 기능

- **열기** — `.md`, `.markdown`, UTF-8 일반 텍스트 파일을 엽니다.
- **편집** — 원문을 그대로 편집합니다. 한글과 이모지도 지원합니다.
- **저장 / 다른 이름으로 저장** — 일반 UTF-8 Markdown 파일로 저장합니다.
- **실시간 미리보기** — 기본 Markdown 서식을 표시합니다.
- **미리보기 표시 / 숨기기** — 편집 공간을 넓힐 수 있습니다.
- **여러 문서** — 문서마다 별도 창을 엽니다.
- **시스템 화면 모드** — macOS의 밝은 모드와 어두운 모드를 따릅니다.

| 동작 | 단축키 |
| --- | --- |
| 새 문서 | `⌘N` |
| 파일 열기 | `⌘O` |
| 저장 | `⌘S` |
| 다른 이름으로 저장 | `⇧⌘S` |
| 실행 취소 | `⌘Z` |
| 다시 실행 | `⇧⌘Z` |

macOS 문서 기능을 사용하므로 기존 파일은 자동 저장될 수 있습니다. 원본을 보존하려면 편집 전에 **다른 이름으로 저장**으로 사본을 만드세요.

### Finder에서 열기

`.md` 파일을 우클릭하고 **다음으로 열기 → Simple Markdown**을 선택합니다. 기본 연결 앱으로 지정하려면 파일의 **정보 가져오기 → 다음으로 열기 → 모두 변경**을 사용하세요.

## 미리보기 지원 범위

| 지원 | 문법 예시 |
| --- | --- |
| 제목 | `# 제목` ~ `###### 제목` |
| 문단과 줄바꿈 | 일반 텍스트, 빈 줄 |
| 굵게 / 기울임 | `**굵게**`, `*기울임*` |
| 인라인 코드 | 백틱으로 감싼 코드 |
| 링크 | `[이름](https://example.com)` |
| 단순 목록 | `- 항목`, `1. 항목` |
| 인용 | `> 인용` |
| 구분선 | `---` |
| 코드 블록 | 백틱 또는 물결표 3개 이상으로 감싼 코드 |

[Example.md](Example.md)를 열면 기본 서식을 한 번에 확인할 수 있습니다.

미리보기는 기본 문법에 집중합니다. 표, 이미지 표시, HTML, 중첩 목록 및 완전한 CommonMark/GitHub 확장 문법 렌더링은 지원하지 않습니다. 미리보기에서 해석하지 못하는 내용도 원문과 저장 파일에는 남습니다.

UTF-8이 아닌 파일은 오류를 표시합니다. UTF-8 BOM은 읽을 때 제거하고, 저장할 때는 BOM 없는 UTF-8로 기록합니다.

## 소스에서 빌드하기

### 준비

- macOS 13 이상
- Swift 5.9 이상을 포함하는 Apple Command Line Tools 또는 Xcode
- 외부 라이브러리 의존성 없음

개발 도구가 없다면 설치합니다.

```sh
xcode-select --install
```

### 빌드와 실행

```sh
git clone https://github.com/kub938/markdown-viewer.git
cd markdown-viewer
./Build.command
./Run.command
```

Finder에서 **Build.command**를 더블 클릭해도 됩니다. 빌드가 완료되면 프로젝트 폴더에 **Simple Markdown.app**이 생성됩니다. Intel Mac에서 빌드하면 Intel용 앱이 생성됩니다.

**Run.command**는 앱이 없으면 먼저 빌드합니다. 소스를 수정한 뒤에는 **Build.command**를 다시 실행하세요.

Xcode에서는 `Package.swift`를 열어 소스를 편집할 수 있습니다. Finder 파일 연결과 앱 실행에는 `Build.command`가 만드는 `.app`을 사용하세요.

## 검사

```sh
./Verify.command
```

XCTest 없이 Command Line Tools만으로 실행하는 검사입니다. UTF-8 왕복, 한글·이모지, 빈 파일, 잘못된 인코딩, BOM, 기본 Markdown 블록, 코드 블록 보존, 코드 펜스, CRLF를 검사합니다.

현재 **자동 검사 8개를 통과**했습니다. Apple Silicon Mac에서 실제 앱을 실행해 파일 열기, 편집, 저장, 다른 이름으로 저장, 다시 열기를 확인했습니다. 모든 macOS 버전과 Intel 환경에서 실행한 것은 아닙니다.

## 프로젝트 구조

```text
Package.swift                       Swift Package 프로젝트
Sources/SimpleMarkdown/
  SimpleMarkdownApp.swift           앱과 저장 메뉴
  MarkdownDocument.swift            문서 읽기 / 쓰기
  EditorView.swift                  원문 편집 화면과 도구 막대
  MarkdownBlocks.swift              기본 블록 구문 분석
  MarkdownPreview.swift             SwiftUI 미리보기
Resources/Info.plist                앱 정보와 파일 연결
Checks/Checks.swift                 자동 검사
Build.command                      .app 빌드
Run.command                        앱 실행
Verify.command                     검사 실행
Example.md                         예제 문서
```

문서 관리는 Apple의 [DocumentGroup](https://developer.apple.com/documentation/swiftui/documentgroup)과 [FileDocument](https://developer.apple.com/documentation/swiftui/filedocument)를 사용하고, 다른 이름으로 저장은 [NSDocument.saveAs](https://developer.apple.com/documentation/appkit/nsdocument/saveas(_:))로 처리합니다. 미리보기는 SwiftUI 화면과 Foundation의 Markdown 인라인 서식 처리를 사용합니다.

## 라이선스

[MIT](LICENSE). 자유롭게 사용하고 수정할 수 있습니다.
