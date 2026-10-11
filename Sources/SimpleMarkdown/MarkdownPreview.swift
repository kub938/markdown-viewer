import SwiftUI

struct MarkdownPreview: View {
    let text: String

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 14) {
                if text.isEmpty {
                    Text("왼쪽에 Markdown을 입력하면 여기에서 미리 볼 수 있습니다.")
                        .foregroundStyle(.secondary)
                }
                ForEach(MarkdownBlocks.parse(text)) { block in
                    blockView(block).frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .textSelection(.enabled)
            .padding(22)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(nsColor: .textBackgroundColor))
        .accessibilityLabel("Markdown 미리보기")
    }

    @ViewBuilder
    private func blockView(_ block: MarkdownBlock) -> some View {
        switch block.kind {
        case .heading(let level):
            inline(block.text).font(.system(size: headingSize(level), weight: .bold))
        case .paragraph:
            inline(block.text).font(.system(size: 15)).lineSpacing(4)
        case .bullet:
            HStack(alignment: .top, spacing: 10) { Text("•"); inline(block.text) }
                .padding(.leading, 6)
        case .numbered(let number):
            HStack(alignment: .top, spacing: 10) { Text(number + "."); inline(block.text) }
                .padding(.leading, 6)
        case .quote:
            HStack(alignment: .top, spacing: 12) {
                Rectangle().fill(.secondary.opacity(0.4)).frame(width: 3)
                inline(block.text).foregroundStyle(.secondary)
            }.fixedSize(horizontal: false, vertical: true)
        case .code:
            Text(block.text)
                .font(.system(size: 13, design: .monospaced))
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 6))
        case .rule:
            Divider()
        }
    }

    private func inline(_ source: String) -> Text {
        let rendered = try? AttributedString(markdown: source, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
        return Text(rendered ?? AttributedString(source))
    }

    private func headingSize(_ level: Int) -> CGFloat {
        [30, 25, 21, 18, 16, 15][max(0, min(level - 1, 5))]
    }
}
