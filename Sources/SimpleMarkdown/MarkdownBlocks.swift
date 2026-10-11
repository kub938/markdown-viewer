import Foundation

struct MarkdownBlock: Identifiable, Equatable {
    enum Kind: Equatable {
        case paragraph, heading(Int), bullet, numbered(String), quote, code, rule
    }
    let id: Int
    let kind: Kind
    let text: String
}

enum MarkdownBlocks {
    static func parse(_ source: String) -> [MarkdownBlock] {
        let lines = source.replacingOccurrences(of: "\r\n", with: "\n").components(separatedBy: "\n")
        var blocks: [MarkdownBlock] = []
        var paragraph: [String] = []
        var code: [String] = []
        var fence: Character?
        var fenceLength = 0
        func append(_ kind: MarkdownBlock.Kind, _ text: String = "") {
            blocks.append(MarkdownBlock(id: blocks.count, kind: kind, text: text))
        }
        func flush() {
            if !paragraph.isEmpty { append(.paragraph, paragraph.joined(separator: "\n")); paragraph = [] }
        }
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            let marker = trimmed.first
            let count = marker.map { m in trimmed.prefix(while: { $0 == m }).count } ?? 0
            if let active = fence {
                if marker == active && count >= fenceLength && trimmed.dropFirst(count).trimmingCharacters(in: .whitespaces).isEmpty {
                    append(.code, code.joined(separator: "\n")); code = []; fence = nil
                } else { code.append(line) }
                continue
            }
            if (marker == "`" || marker == "~") && count >= 3 {
                flush(); fence = marker; fenceLength = count; continue
            }
            if trimmed.isEmpty { flush(); continue }
            if marker == "#" && (1...6).contains(count) && trimmed.dropFirst(count).first == " " {
                flush(); append(.heading(count), String(trimmed.dropFirst(count + 1))); continue
            }
            let compact = trimmed.filter { !$0.isWhitespace }
            if compact.count >= 3 && ["-", "*", "_"].contains(String(compact.first!)) && compact.allSatisfy({ $0 == compact.first }) {
                flush(); append(.rule); continue
            }
            if trimmed.hasPrefix(">") {
                flush(); append(.quote, String(trimmed.dropFirst()).trimmingCharacters(in: .whitespaces)); continue
            }
            if trimmed.hasPrefix("- ") || trimmed.hasPrefix("* ") || trimmed.hasPrefix("+ ") {
                flush(); append(.bullet, String(trimmed.dropFirst(2))); continue
            }
            let digits = trimmed.prefix(while: { $0.isNumber })
            let rest = trimmed.dropFirst(digits.count)
            if !digits.isEmpty && (rest.hasPrefix(". ") || rest.hasPrefix(") ")) {
                flush(); append(.numbered(String(digits)), String(rest.dropFirst(2))); continue
            }
            paragraph.append(line)
        }
        if fence != nil { append(.code, code.joined(separator: "\n")) }
        flush()
        return blocks
    }
}
