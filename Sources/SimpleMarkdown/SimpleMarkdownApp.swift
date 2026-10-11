import SwiftUI
import AppKit

@main
struct SimpleMarkdownApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MarkdownDocument()) { file in
            EditorView(document: file.$document)
        }
        .commands {
            CommandGroup(replacing: .saveItem) {
                Button("저장") { DocumentActions.save() }
                    .keyboardShortcut("s", modifiers: .command)
                Button("다른 이름으로 저장…") { DocumentActions.saveAs() }
                    .keyboardShortcut("s", modifiers: [.command, .shift])
            }
        }
    }
}

@MainActor
enum DocumentActions {
    static func open() { NSDocumentController.shared.openDocument(nil) }
    static func save() { NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: nil) }
    static func saveAs() { NSApp.sendAction(#selector(NSDocument.saveAs(_:)), to: nil, from: nil) }
}
