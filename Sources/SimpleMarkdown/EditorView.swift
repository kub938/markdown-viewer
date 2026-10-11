import SwiftUI

struct EditorView: View {
    @Binding var document: MarkdownDocument
    @State private var showPreview = true

    var body: some View {
        VStack(spacing: 0) {
            HSplitView {
                VStack(alignment: .leading, spacing: 0) {
                    paneTitle("MARKDOWN")
                    TextEditor(text: $document.text)
                        .font(.system(size: 15, design: .monospaced))
                        .padding(10)
                        .accessibilityLabel("Markdown 원문 편집")
                }
                .frame(minWidth: 260)
                if showPreview {
                    VStack(alignment: .leading, spacing: 0) {
                        paneTitle("미리보기")
                        MarkdownPreview(text: document.text)
                    }
                    .frame(minWidth: 260)
                }
            }
            Divider()
            HStack {
                Text("UTF-8 · Markdown")
                Spacer()
                Text("\(document.text.count)자")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
        }
        .frame(minWidth: 600, minHeight: 400)
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button(action: DocumentActions.open) { Label("열기", systemImage: "folder") }
                    .help("파일 열기 (⌘O)")
                Button(action: DocumentActions.save) { Label("저장", systemImage: "square.and.arrow.down") }
                    .help("저장 (⌘S)")
                Button(action: DocumentActions.saveAs) { Label("다른 이름으로 저장", systemImage: "doc.badge.plus") }
                    .help("다른 이름으로 저장 (⇧⌘S)")
                Toggle(isOn: $showPreview) { Label("미리보기", systemImage: "sidebar.right") }
                    .help("미리보기 표시 / 숨기기")
            }
        }
    }

    private func paneTitle(_ title: String) -> some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.quaternary.opacity(0.3))
    }
}
