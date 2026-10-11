import Foundation

@main
struct Checks {
    static func main() throws {
        var count = 0
        func check(_ condition: Bool, _ name: String) throws {
            guard condition else {
                throw NSError(domain: "MarkdownCheck", code: 1, userInfo: [NSLocalizedDescriptionKey: name])
            }
            count += 1
            print("PASS: \(name)")
        }
        let source = "# 한글 😀\r\n\n**강조**\n"
        try check(MarkdownCodec.decode(MarkdownCodec.encode(source)) == source, "UTF-8 / Korean / emoji / CRLF round trip")
        try check(MarkdownCodec.decode(Data()) == "" && MarkdownBlocks.parse("").isEmpty, "Empty document")
        var rejected = false
        do { _ = try MarkdownCodec.decode(Data([0xff, 0xfe, 0x00])) } catch { rejected = true }
        try check(rejected, "Invalid UTF-8 rejected")
        try check(MarkdownCodec.decode(Data([0xef, 0xbb, 0xbf]) + Data("한글".utf8)) == "한글", "UTF-8 BOM")
        let blocks = MarkdownBlocks.parse("# 제목\n\n내용\n둘째 줄\n\n- 항목\n2. 순서\n> 인용\n---")
        try check(blocks.map(\.kind) == [.heading(1), .paragraph, .bullet, .numbered("2"), .quote, .rule] && blocks[1].text == "내용\n둘째 줄", "Block structure")
        let code = MarkdownBlocks.parse("```swift\n# 코드\n- 코드\n```\n끝")
        try check(code.map(\.kind) == [.code, .paragraph] && code[0].text == "# 코드\n- 코드", "Literal fenced code")
        try check(MarkdownBlocks.parse("~~~\nabc").first?.text == "abc" && MarkdownBlocks.parse("````\n```\n````").first?.text == "```", "Unclosed / long fences")
        try check(MarkdownBlocks.parse("#heading\r\n\r\n## 제목").map(\.kind) == [.paragraph, .heading(2)], "CRLF / literal hash")
        print("All \(count) checks passed.")
    }
}
