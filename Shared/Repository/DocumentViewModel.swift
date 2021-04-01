//
//  DocumentViewModel.swift
//  SquatchNotes
//
//  Created by Hutson on 3/30/21.
//

import SwiftUI
import UniformTypeIdentifiers

//extension UTType {
//    static var markdownText: UTType {
//        UTType(importedAs: "net.daringfiregall.markdown")
//    }
//}

struct TextFile: FileDocument {
    static var readableContentTypes: [UTType] { [.plainText] }
    
    var text = ""
    
    init(initialText: String = "") {
        text = initialText
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func fileWrapper(configuration:WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
